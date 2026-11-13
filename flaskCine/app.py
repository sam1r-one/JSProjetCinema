from time import strftime

from flask import Flask, jsonify, render_template
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
def home():
    connection = None
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            sql = ("SELECT seance.id_seance, "
                   "seance.date_heure, "
                   "seance.version_langue, "
                   "film.nom_film, film.resume, "
                   "salle.numero_salle "
                   "FROM seance JOIN film ON seance.id_film = film.id_film JOIN salle ON seance.id_salle = salle.id_salle WHERE seance.date_heure >= NOW() ORDER BY seance.date_heure ASC LIMIT 1;")
            cursor.execute(sql)
            seance = cursor.fetchone()
        print(seance)
        return jsonify({
            "status": "succès",
            "message": "connexion BDD réussie !",
            "donnees": seance
        }),200

    except pymysql.MySQLError as error:
        return jsonify({
            "status": "erreur",
            "message": f"Impossible de connexion ! {str(error)}"
        }),500

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
            cursor.execute(sql, (id_film,));
            film = cursor.fetchone()

        print(f"Film récuperer : {film}")
        return render_template("film.html", film=film)

    except pymysql.MySQLError as error:
        return f'Erreur BDD {(error)}',500
    finally:
        if connection and connection.open:
            connection.close()


@app.route('/getseance/<int:numSalle>')
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
                    AND seance.date_heure >= NOW()
                  ORDER BY seance.date_heure ASC; \
                  """
            cursor.execute(sql, (numSalle,));
            result = cursor.fetchall();

        liste_seance = [];
        for row in result:
            seance_formatee = {
                "horaire": row["date_heure"].strftime("%Hh%M"),
                "titre":  row["nom_film"],
                "version" : row["version_langue"],
                "interdit_16" : "16" if row["interdit_16"] else "0",
            }
            liste_seance.append(seance_formatee)

        return jsonify(liste_seance)

    except pymysql.MySQLError as error:
        return f'Erreur BDD {(error)}',500
    finally:
        if connection and connection.open:
            connection.close()

if __name__ == '__main__':
    app.run(debug=True)
