from time import strftime

from flask import Flask, jsonify, render_template, request
import pymysql
import pymysql.cursors
from config import Config

app = Flask(__name__)

def get_db_connection():
    return pymysql.connect(
        host=Config.DB_HOST,
        user=Config.DB_USER,
        password=Config.DB_PASSWORD,
        database=Config.DB_NAME,
        cursorclass=pymysql.cursors.DictCursor
    )
@app.route('/')
def accueil():
    return render_template("index.html")
@app.route('/seances')
def home():
    connection = None
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            cursor.execute("UPDATE seance SET date_heure = CONCAT(CURDATE(), ' ', TIME(date_heure));")
            connection.commit()
            sql = """
                  SELECT seance.id_seance,
                         seance.date_heure,
                         seance.version_langue,
                         film.id_film,
                         film.nom_film,
                         salle.numero_salle
                  FROM seance
                  JOIN film ON seance.id_film = film.id_film
                  JOIN salle ON seance.id_salle = salle.id_salle
                  WHERE seance.date_heure >= NOW()
                  ORDER BY seance.date_heure ASC;
                  """
            cursor.execute(sql)
            seances_liste = cursor.fetchall()

            return render_template("seances.html", seances=seances_liste)

    except pymysql.MySQLError as error:
        return f'Erreur BDD {error}', 500

    finally:
        if connection and connection.open:
            connection.close()

@app.route('/film/<int:id_film>')
def film(id_film):
    connection = None
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = "SELECT id_film, nom_film, duree, interdit_16, langue, resume FROM film WHERE id_film = %s;"
            cursor.execute(sql, (id_film,))
            film = cursor.fetchone()

        print(f"Film récuperer : {film}")
        return render_template("film.html", film=film)

    except pymysql.MySQLError as error:
        return f'Erreur BDD {error}',500
    finally:
        if connection and connection.open:
            connection.close()


@app.route('/getseances/<int:numSalle>')
def getseance(numSalle):
    connection = None
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = """
                  SELECT film.nom_film, seance.date_heure, seance.version_langue, film.interdit_16
                  FROM seance
                           JOIN film ON seance.id_film = film.id_film
                           JOIN salle ON seance.id_salle = salle.id_salle
                  WHERE salle.numero_salle = %s
                    AND DATE(seance.date_heure) = CURDATE()
                  ORDER BY seance.date_heure ASC;
                  """
            cursor.execute(sql, (numSalle,))
            result = cursor.fetchall()

        liste_seance = []
        for seance in result:
            if seance["interdit_16"] == 1:
                interdiction = "16"
            else:
                interdiction = "0"

            seance_formatee = {
                "horaire": seance["date_heure"].strftime("%Hh%M"),
                "titre": seance["nom_film"],
                "version": seance["version_langue"],
                "interdit_16": interdiction
            }
            liste_seance.append(seance_formatee)

        return jsonify(liste_seance)

    except pymysql.MySQLError as error:
        return f'Erreur BDD {error}',500
    finally:
        if connection and connection.open:
            connection.close()
@app.route("/form", methods=["GET"])
def afficher_formulaire():
    return render_template("formulaire.html")

@app.route("/traitement", methods=["POST"])
def traitement():
    titre = request.form.get("titre", "").strip()
    duree = request.form.get("duree", "").strip()
    langue = request.form.get("langue", "").strip()
    interdiction_16 = request.form.get("interdiction_16") is not None
    resume = request.form.get("resume", "").strip()
    affiche = request.form.get("affiche", "").strip()

    print(f"Titre: {titre}")
    print(f"Duree: {duree}")
    print(f"Langue: {langue}")
    print(f"Interdit_16: {interdiction_16}")
    print(f"Resume: {resume}")
    print(f"Affiche: {affiche}")

    message = f"Le film {titre} est enregistré"

    return render_template(
        "traitement.html",
        message=message,
        titre=titre,
        duree=duree,
        langue=langue,
        interdiction_16=interdiction_16,
        resume=resume,
        affiche=affiche,
    )

if __name__ == '__main__':
    app.run(debug=True)
