from flask import Flask, render_template, request
from flask_bootstrap import Bootstrap
import psycopg2

app = Flask(__name__)
Bootstrap(app)

sql2 = """
    SELECT *
    FROM majors
    """
sql3 = """
    SELECT *
    FROM subjects
    """

@app.route('/')
def index():
    return render_template("index.html")

@app.route('/courses')
def courses():
    con = psycopg2.connect(
        "host=localhost dbname=bigdata user=bigdata password=8GfwPEB*rQhsJs-$ port=5432")
    cur2 = con.cursor()
    cur2.execute(sql2)
    major = request.args.get("major", "")
    catalog_year = request.args.get("catalog_year", "")
    view_chart = request.args.get("view_chart", "")
    if not major:
        return render_template("form.html", cur2=cur2)
    if (major == "Select your major"):
        return render_template("form4.html", cur2=cur2)
    if (catalog_year == "Select Catalog Year"):
        return render_template("form2.html", cur2=cur2)
    if (view_chart == "Choose View"):
        return render_template("form3.html", cur2=cur2)
    else:
        con = psycopg2.connect(
            "host=localhost dbname=bigdata user=bigdata password=8GfwPEB*rQhsJs-$ port=5432")
        cur = con.cursor()
        cur2 = con.cursor()
        sql = """
            SELECT subject, number, level, instruction_type, credits, title, description
            FROM courses(%s, %s)
            """
        cur.execute(sql, (major, catalog_year))
        cur2.execute(sql2)
        if (view_chart == "Table View"):
            return render_template("courses-table.html", major=major, catalog_year=catalog_year, view_chart=view_chart, cur=cur, cur2=cur2)
        elif (view_chart == "Bubble Chart"):
            return render_template("courses-bubble.html", major=major, catalog_year=catalog_year, view_chart=view_chart, cur=cur, cur2=cur2)


@app.route('/programs')
def programs():
    catalog = request.args.get("catalog", "")
    if not catalog:
        data = None
        return render_template("programs.html", data=data)
    else:
        con = psycopg2.connect("host=localhost dbname=bigdata user=bigdata password=8GfwPEB*rQhsJs-$ port=5432")
        cur = con.cursor()
        sql = """
            SELECT *
            FROM list_programs(%s)
        """
        cur.execute(sql, (catalog,))
        data = cur.fetchall()
        return render_template("programs.html", catalog=catalog, data=data)


@app.route('/class')
def percentage():
    class_size = request.args.get("size", "")
    if not class_size:
        data = None
        return render_template("class-size.html", data=data)
    if (class_size == "Select a class size"):
        return render_template("class-size2.html")
    else:
        con = psycopg2.connect("host=localhost dbname=bigdata user=bigdata password=8GfwPEB*rQhsJs-$ port=5432")
        cur = con.cursor()
        sql = """
            SELECT *
            FROM percentage_by_size(%s)
            """
        cur.execute(sql, (class_size,))
        data = cur.fetchone()
        return render_template("class-size.html", size=class_size, data=data)

@app.route('/credits')
def credit():
    con = psycopg2.connect(
        "host=localhost dbname=bigdata user=bigdata password=8GfwPEB*rQhsJs-$ port=5432")
    cur2 = con.cursor()
    cur2.execute(sql2)
    majors = request.args.getlist('majors')
    print(majors)
    if not majors:
        data = None
        return render_template("credits.html", data=data, cur2=cur2)
    else:
        conn = psycopg2.connect("dbname=bigdata user=bigdata host=localhost password=8GfwPEB*rQhsJs-$ port=5432 connect_timeout=5")
        cursor = conn.cursor()
        cur2 = con.cursor()
        cur2.execute(sql2)
        args = (','.join('\'{0}\''.format(item) for item in majors))
        sql = """
                SELECT major, ROUND(AVG(CAST((CAST(credits as CHAR(1))) as int)),2)          
	            FROM department
                WHERE major IN (%s)
	            GROUP BY major
	            ORDER BY round ASC
                """
    cursor.execute(sql % args)
    data = cursor.fetchall()
    return render_template('credits.html', data= data, cur2=cur2)

@app.route("/pre_req")
def find_major():
    conn = psycopg2.connect("dbname=bigdata user=bigdata host=localhost password=8GfwPEB*rQhsJs-$ port=5432 connect_timeout=5")
    cur2 = conn.cursor()
    cur2.execute(sql3)
    major = request.args.get("major", "")
    if not major:
        return render_template("pre_req_open_page.html", cur2=cur2)
    if (major == "Select your major"):
        return render_template("pre_req_open_page2.html", cur2=cur2)
    else:
        conn = psycopg2.connect("dbname=bigdata user=bigdata host=localhost password=8GfwPEB*rQhsJs-$ port=5432 connect_timeout=5")
        cursor = conn.cursor()
        cur2 = conn.cursor()
        pre_req = """SELECT subject, pre
                 FROM percent_pre
                 WHERE subject = (%s)"""
        cursor.execute(pre_req, (major,))
        cur2.execute(sql3)
        av_pre = cursor.fetchall()
        return render_template("pre_req_home_page.html", pre=av_pre, cur2=cur2)

