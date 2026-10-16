from flask import Flask, jsonify
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

    if seance is None:


if __name__ == '__main__':
    app.run()
