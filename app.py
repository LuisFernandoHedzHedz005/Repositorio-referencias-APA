from flask import Flask, render_template, request, redirect, flash, session, url_for
import mysql.connector
from mysql.connector import Error
from datetime import datetime

app = Flask(__name__)
app.secret_key = 'tu_clave_secreta_muy_segura' 

# Configuración de la base de datos
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': 'Dracohunter#190603',
    'database': 'bibliografia_ico'
}

def get_tipos_fuente():
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM tipos_fuente")
        return cursor.fetchall()
    finally:
        cursor.close()
        conn.close()

def format_apa_libro(fuente, autores):
    autores_str = ', '.join([f"{autor['nombre_completo']}" for autor in autores])
    if len(autores) > 1:
        autores_str = ', '.join(autores_str.split(', ')[:-1]) + ' & ' + autores_str.split(', ')[-1]
    
    # Construir la referencia parte por parte
    partes = [autores_str]
    
    # Añadir año si existe
    if fuente.get('anio'):
        partes.append(f"({fuente['anio']})")
    else:
        partes.append("(s.f.)")
    
    # Añadir título
    partes.append(f"{fuente['titulo']}.")
    
    # Añadir lugar y editorial si ambos existen
    if fuente.get('lugar') and fuente.get('editorial'):
        partes.append(f"{fuente['lugar']}: {fuente['editorial']}.")
    elif fuente.get('lugar'):
        partes.append(f"{fuente['lugar']}.")
    elif fuente.get('editorial'):
        partes.append(f"{fuente['editorial']}.")
    
    return ' '.join(partes)

def format_apa_electronica(fuente, autores):
    autores_str = ', '.join([f"{autor['nombre_completo']}" for autor in autores])
    if len(autores) > 1:
        autores_str = ', '.join(autores_str.split(', ')[:-1]) + ' & ' + autores_str.split(', ')[-1]
    
    partes = [autores_str]
    
    if fuente.get('anio'):
        partes.append(f"({fuente['anio']})")
    
    partes.append(f"{fuente['titulo']}.")
    
    if fuente.get('url'):
        fecha_consulta = datetime.now().strftime("%d de %B de %Y")
        partes.append(f"Recuperado el {fecha_consulta} de {fuente['url']}")
    
    return ' '.join(partes)

def format_apa_articulo(fuente, autores):
    autores_str = ', '.join([f"{autor['nombre_completo']}" for autor in autores])
    if len(autores) > 1:
        autores_str = ', '.join(autores_str.split(', ')[:-1]) + ' & ' + autores_str.split(', ')[-1]
    
    partes = [autores_str]
    
    if fuente.get('anio'):
        partes.append(f"({fuente['anio']})")
    
    partes.append(f"{fuente['titulo']}.")
    
    if fuente.get('editorial') and fuente.get('lugar'):
        partes.append(f"{fuente['editorial']}, {fuente['lugar']}.")
    elif fuente.get('editorial'):
        partes.append(f"{fuente['editorial']}.")
    elif fuente.get('lugar'):
        partes.append(f"{fuente['lugar']}.")
    
    return ' '.join(partes)

def format_ieee_libro(fuente, autores):
    if not autores:
        autores_str = "Anón."
    else:
        autores_str = ', '.join([f"{autor['nombre_completo'].split()[0][0]}. {autor['nombre_completo'].split()[-1]}" 
                              for autor in autores])
    
    partes = [autores_str, f"{fuente['titulo']},"]
    
    if fuente.get('lugar') and fuente.get('editorial'):
        partes.append(f"{fuente['lugar']}: {fuente['editorial']},")
    elif fuente.get('lugar'):
        partes.append(f"{fuente['lugar']},")
    elif fuente.get('editorial'):
        partes.append(f"{fuente['editorial']},")
    
    if fuente.get('anio'):
        partes.append(f"{fuente['anio']}.")
    else:
        partes[-1] = partes[-1].replace(',', '.')  
    
    return ' '.join(partes)

def format_ieee_electronica(fuente, autores):
    if not autores:
        autores_str = "Anón."
    else:
        autores_str = ', '.join([f"{autor['nombre_completo'].split()[0][0]}. {autor['nombre_completo'].split()[-1]}, " 
                              for autor in autores])
    
    partes = [autores_str]
    
    if fuente.get('anio'):
        partes.append(f"{fuente['anio']},")
    
    partes.append(f"\"{fuente['titulo']}\", [En línea]. Disponible:")
    
    if fuente.get('url'):
        fecha_consulta = datetime.now().strftime("%Y-%m-%d")
        partes.append(f"{fuente['url']}. [Accedido: {fecha_consulta}].")
    
    return ' '.join(partes)
    

def format_ieee_articulo(fuente, autores):
    if not autores:
        autores_str = "Anón."
    else:
        autores_str = ', '.join([f"{autor['nombre_completo'].split()[0][0]}. {autor['nombre_completo'].split()[-1]}" 
                              for autor in autores])
    
    partes = [autores_str, f"\"{fuente['titulo']}\","]
    
    if fuente.get('editorial'):
        partes.append(f"{fuente['editorial']},")
    
    if fuente.get('anio'):
        partes.append(f" {fuente['anio']}.")
    else:
        partes.append(".")
    
    return ' '.join(partes)
'''
def format_apa_libro(fuente, autores):
    autores_str = ', '.join([f"{autor['nombre_completo']}" for autor in autores])
    if len(autores) > 1:
        autores_str = ', '.join(autores_str.split(', ')[:-1]) + ' & ' + autores_str.split(', ')[-1]
    
    #anio = f"({fuente['anio']})" if fuente['anio'] else "(s.f.)"
    #editorial = fuente['editorial'] if fuente['editorial'] else "s.e."
    #lugar = fuente['lugar'] if fuente['lugar'] else "s.l."

    anio = f"({fuente['anio']})" if fuente['anio'] else "(s.f.)"
    editorial = fuente['editorial'] if fuente['editorial'] else ""
    lugar = fuente['lugar'] if fuente['lugar'] else ""
    
    return f"{autores_str} {anio}. {fuente['titulo']}. {lugar}: {editorial}."

def format_apa_electronica(fuente, autores):
    autores_str = ', '.join([f"{autor['nombre_completo']}" for autor in autores])
    if len(autores) > 1:
        autores_str = ', '.join(autores_str.split(', ')[:-1]) + ' & ' + autores_str.split(', ')[-1]
    
    anio = f"({fuente['anio']})" if fuente['anio'] else "(s.f.)"
    fecha_consulta = datetime.now().strftime("%d de %B de %Y")
    
    return f"{autores_str} {anio}. {fuente['titulo']}. Recuperado el {fecha_consulta} de {fuente['url']}"

def format_apa_articulo(fuente, autores):
    autores_str = ', '.join([f"{autor['nombre_completo']}" for autor in autores])
    if len(autores) > 1:
        autores_str = ', '.join(autores_str.split(', ')[:-1]) + ' & ' + autores_str.split(', ')[-1]
    
    #anio = f"({fuente['anio']})" if fuente['anio'] else "(s.f.)"
    #editorial = fuente['editorial'] if fuente['editorial'] else "s.e."
    #lugar = fuente['lugar'] if fuente['lugar'] else "s.l."

    anio = f"({fuente['anio']})" if fuente['anio'] else "(s.f.)"
    editorial = fuente['editorial'] if fuente['editorial'] else ""
    lugar = fuente['lugar'] if fuente['lugar'] else ""
    
    return f"{autores_str} {anio}. {fuente['titulo']}. {editorial}, {lugar}."

# Funciones IEEE específicas por tipo de fuente
def format_ieee_libro(fuente, autores):
    if not autores:
        autores_str = "Anón."
    else:
        autores_str = ', '.join([f"{autor['nombre_completo'].split()[0][0]}. {autor['nombre_completo'].split()[-1]}" 
                              for autor in autores])
    
    #anio = fuente['anio'] if fuente['anio'] else "s.f."
    #editorial = fuente['editorial'] if fuente['editorial'] else "[s.e.]"
    #lugar = fuente['lugar'] if fuente['lugar'] else "[s.l.]"

    anio = fuente['anio'] if fuente['anio'] else ""
    editorial = fuente['editorial'] if fuente['editorial'] else ""
    lugar = fuente['lugar'] if fuente['lugar'] else ""
    
    return f"{autores_str}, {fuente['titulo']}, {lugar}: {editorial}, {anio}."

def format_ieee_electronica(fuente, autores):
    if not autores:
        autores_str = "Anón."
    else:
        autores_str = ', '.join([f"{autor['nombre_completo'].split()[0][0]}. {autor['nombre_completo'].split()[-1]}" 
                              for autor in autores])
    
    #anio = fuente['anio'] if fuente['anio'] else "s.f."
    anio = fuente['anio'] if fuente['anio'] else ""
    fecha_consulta = datetime.now().strftime("%Y-%m-%d")
    
    return f"{autores_str}, \"{fuente['titulo']}\", [En línea]. Disponible: {fuente['url']}. [Accedido: {fecha_consulta}]."

def format_ieee_articulo(fuente, autores):
    if not autores:
        autores_str = "Anón."
    else:
        autores_str = ', '.join([f"{autor['nombre_completo'].split()[0][0]}. {autor['nombre_completo'].split()[-1]}" 
                              for autor in autores])
    
    #anio = fuente['anio'] if fuente['anio'] else "s.f."
    #editorial = fuente['editorial'] if fuente['editorial'] else "[s.e.]"
    #lugar = fuente['lugar'] if fuente['lugar'] else "[s.l.]"

    anio = fuente['anio'] if fuente['anio'] else ""
    editorial = fuente['editorial'] if fuente['editorial'] else ""
    lugar = fuente['lugar'] if fuente['lugar'] else ""
    
    return f"{autores_str}, \"{fuente['titulo']}\", {editorial}, vol., no., pp., {anio}."

'''
    
# Función para determinar el formato correcto
def generar_cita(estilo, tipo_fuente, fuente, autores):
    formatos = {
        'APA': {
            1: format_apa_libro,       # Libros
            2: format_apa_electronica,  # Fuentes electronicas
            3: format_apa_articulo      # Articulos
        },
        'IEEE': {
            1: format_ieee_libro,
            2: format_ieee_electronica,
            3: format_ieee_articulo
        }
    }
    return formatos[estilo][tipo_fuente](fuente, autores)

@app.route('/', methods=['GET', 'POST'])
def index():
    estilos = ['APA', 'IEEE']
    tipos_fuente = get_tipos_fuente()
    resultados = []

    if request.method == 'POST':
        estilo = request.form.get('estilo')
        tipo_fuente = int(request.form.get('tipo_fuente'))
        busqueda = request.form.get('query')

        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        try:
            query = """
                SELECT f.*, tf.nombre as tipo_nombre 
                FROM fuentes f
                JOIN tipos_fuente tf ON f.tipo_id = tf.id
                WHERE f.tipo_id = %s 
                AND LOWER(f.titulo) LIKE %s
            """
            search_term = f"%{busqueda.lower()}%"
            cursor.execute(query, (tipo_fuente, search_term))
            fuentes = cursor.fetchall()

            for fuente in fuentes:
                autores = get_autores(fuente['id'])
                cita = generar_cita(estilo, tipo_fuente, fuente, autores)
                
                resultados.append({
                    'titulo': fuente['titulo'],
                    'cita': cita,
                    'tipo': fuente['tipo_nombre'],
                    'estilo': estilo
                })

        finally:
            cursor.close()
            conn.close()

    return render_template('index.html', 
                         estilos=estilos,
                         tipos_fuente=tipos_fuente,
                         resultados=resultados)

def campo_seguro(valor, default=""):
    return valor if valor is not None else default

def get_autores(fuente_id):
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("""
            SELECT a.* 
            FROM autores a
            JOIN autor_fuente af ON a.id = af.autor_id
            WHERE af.fuente_id = %s
        """, (fuente_id,))
        return cursor.fetchall()
    finally:
        cursor.close()
        conn.close()

# Login de administrador
@app.route('/admin/login', methods=['GET', 'POST'])
def admin_login():
    if request.method == 'POST':
        usuario = request.form['usuario']
        contrasena = request.form['contrasena']
        
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        try:
            cursor.execute(
                "SELECT * FROM administrador WHERE usuario = %s AND contrasena = %s",
                (usuario, contrasena)
            )
            admin = cursor.fetchone()
            
            if admin:
                session['admin_logged_in'] = True
                session['admin_usuario'] = usuario
                return redirect(url_for('admin_dashboard'))
            else:
                return render_template('admin_login.html', error='Credenciales incorrectas')
        finally:
            cursor.close()
            conn.close()
    
    return render_template('admin_login.html')

# Dashboard de administrador
@app.route('/admin/dashboard')
def admin_dashboard():
    if not session.get('admin_logged_in'):
        return redirect(url_for('admin_login'))
    
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("""
            SELECT f.*, tf.nombre as tipo_nombre,
                   GROUP_CONCAT(DISTINCT CONCAT(a.nombre, ' (Sem. ', a.semestre, ')') SEPARATOR ', ') AS asignaturas
            FROM fuentes f
            JOIN tipos_fuente tf ON f.tipo_id = tf.id
            LEFT JOIN fuente_asignatura fa ON f.id = fa.fuente_id
            LEFT JOIN asignaturas a ON fa.asignatura_id = a.id
            GROUP BY f.id
        """)
        fuentes = cursor.fetchall()
        return render_template('admin_dashboard.html', fuentes=fuentes)
    finally:
        cursor.close()
        conn.close()



@app.route('/admin/delete/<int:id>', methods=['POST'])
def delete_fuente(id):
    if not session.get('admin_logged_in'):
        return redirect(url_for('admin_login'))
    
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    try:
        # Eliminar relaciones primero
        cursor.execute("DELETE FROM autor_fuente WHERE fuente_id = %s", (id,))
        cursor.execute("DELETE FROM fuente_asignatura WHERE fuente_id = %s", (id,))
        
        # Eliminar la fuente
        cursor.execute("DELETE FROM fuentes WHERE id = %s", (id,))
        conn.commit()
        flash('Fuente eliminada correctamente', 'success')
    except Exception as e:
        conn.rollback()
        flash(f'Error al eliminar: {str(e)}', 'danger')
    finally:
        cursor.close()
        conn.close()
    
    return redirect(url_for('admin_dashboard'))

# Ruta para editar fuente
@app.route('/admin/edit/<int:id>', methods=['GET', 'POST'])
def edit_fuente(id):
    if not session.get('admin_logged_in'):
        return redirect(url_for('admin_login'))
    
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)

    if request.method == 'GET':
        try:
            # Obtener datos principales
            cursor.execute("SELECT * FROM fuentes WHERE id = %s", (id,))
            fuente = cursor.fetchone()
            
            # Obtener autores de la fuente
            autores = get_autores(id)  
            
            # Obtener tipos de fuente
            cursor.execute("SELECT * FROM tipos_fuente")
            tipos = cursor.fetchall()
            
            # Obtener asignaturas
            cursor.execute("SELECT * FROM asignaturas")
            asignaturas = cursor.fetchall()
            
            # Obtener asignaturas seleccionadas
            cursor.execute("SELECT asignatura_id FROM fuente_asignatura WHERE fuente_id = %s", (id,))
            asignaturas_seleccionadas = [row['asignatura_id'] for row in cursor.fetchall()]
            
            return render_template('edit_fuente.html', 
                                 fuente=fuente, 
                                 autores=autores,  
                                 tipos=tipos,
                                 asignaturas=asignaturas,
                                 asignaturas_seleccionadas=asignaturas_seleccionadas)
        finally:
            cursor.close()
            conn.close()

    
    if request.method == 'POST':
        try:
            # Actualizar la fuente principal
            datos = {
                'titulo': request.form['titulo'],
                'tipo_id': request.form['tipo_id'],
                'editorial': request.form.get('editorial', '') or None,
                'anio': request.form.get('anio') or None,
                'lugar': request.form.get('lugar', '') or None,
                'url': request.form.get('url', ''),
                'id': id
            }
            
            query = """
                UPDATE fuentes 
                SET titulo = %(titulo)s, 
                    tipo_id = %(tipo_id)s, 
                    editorial = %(editorial)s, 
                    anio = %(anio)s, 
                    lugar = %(lugar)s, 
                    url = %(url)s 
                WHERE id = %(id)s
            """
            
            cursor.execute(query, datos)
            
            # Manejar autores
            autores_nombres = request.form.getlist('autores[]')
            
            # Primero eliminar las relaciones existentes
            cursor.execute("DELETE FROM autor_fuente WHERE fuente_id = %s", (id,))
            
            # Insertar nuevos autores o actualizar existentes
            for nombre_autor in autores_nombres:
                if nombre_autor.strip():  
                    # Buscar si el autor ya existe
                    cursor.execute("SELECT id FROM autores WHERE nombre_completo = %s", (nombre_autor,))
                    autor = cursor.fetchone()
                    
                    if autor:
                        autor_id = autor['id']
                    else:
                        # Crear nuevo autor
                        cursor.execute("INSERT INTO autores (nombre_completo) VALUES (%s)", (nombre_autor,))
                        autor_id = cursor.lastrowid
                    
                    # Crear relación autor-fuente
                    cursor.execute("INSERT INTO autor_fuente (autor_id, fuente_id) VALUES (%s, %s)", 
                                (autor_id, id))
                    
                    # Manejar asignaturas
            asignaturas_ids = request.form.getlist('asignaturas')
            
            # Eliminar relaciones existentes
            cursor.execute("DELETE FROM fuente_asignatura WHERE fuente_id = %s", (id,))
            
            # Insertar nuevas relaciones
            for asignatura_id in asignaturas_ids:
                cursor.execute("INSERT INTO fuente_asignatura (fuente_id, asignatura_id) VALUES (%s, %s)",
                             (id, asignatura_id))
            
            conn.commit()
            flash('Cambios guardados exitosamente', 'success')
        except Exception as e:
            conn.rollback()
            flash(f'Error al actualizar: {str(e)}', 'danger')
        finally:
            cursor.close()
            conn.close()
        return redirect(url_for('admin_dashboard'))
    
    try:
        # Obtener datos de la fuente
        cursor.execute("SELECT * FROM fuentes WHERE id = %s", (id,))
        fuente = cursor.fetchone()
        
        # Obtener autores de la fuente
        autores = get_autores(id)
        
        # Obtener tipos de fuente
        cursor.execute("SELECT * FROM tipos_fuente")
        tipos = cursor.fetchall()
        
        return render_template('edit_fuente.html', 
                             fuente=fuente, 
                             autores=autores,
                             tipos=tipos)
    finally:
        cursor.close()
        conn.close()

# Actualizar la función nueva_fuente para manejar autores
@app.route('/admin/nueva', methods=['GET', 'POST'])
def nueva_fuente():
    if not session.get('admin_logged_in'):
        return redirect(url_for('admin_login'))
    
    if request.method == 'GET':
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor(dictionary=True)
        try:
            # Obtener tipos y asignaturas
            cursor.execute("SELECT * FROM tipos_fuente")
            tipos = cursor.fetchall()
            
            cursor.execute("SELECT * FROM asignaturas")
            asignaturas = cursor.fetchall()
            
            return render_template('nueva_fuente.html', 
                                tipos=tipos,
                                asignaturas=asignaturas)
        finally:
            cursor.close()
            conn.close()
    
    if request.method == 'POST':
        conn = mysql.connector.connect(**db_config)
        cursor = conn.cursor()
        try:
            # Guardar datos de la nueva fuente
            datos = {
                'titulo': request.form['titulo'],
                'tipo_id': request.form['tipo_id'],
                'editorial': request.form.get('editorial', '') or None,
                'anio': request.form.get('anio') or None,
                'lugar': request.form.get('lugar', '') or None,
                'url': request.form.get('url', '')
            }
            
            query = """
                INSERT INTO fuentes 
                (titulo, tipo_id, editorial, anio, lugar, url) 
                VALUES 
                (%(titulo)s, %(tipo_id)s, %(editorial)s, %(anio)s, %(lugar)s, %(url)s)
            """
            
            cursor.execute(query, datos)
            fuente_id = cursor.lastrowid
            
            # Manejar autores
            autores_nombres = request.form.getlist('autores[]')
            
            for nombre_autor in autores_nombres:
                if nombre_autor.strip(): 
                    # Buscar si el autor ya existe
                    cursor.execute("SELECT id FROM autores WHERE nombre_completo = %s", (nombre_autor,))
                    autor = cursor.fetchone()
                    
                    if autor:
                        autor_id = autor[0]
                    else:
                        # Crear nuevo autor
                        cursor.execute("INSERT INTO autores (nombre_completo) VALUES (%s)", (nombre_autor,))
                        autor_id = cursor.lastrowid
                    
                    # Crear relación autor-fuente
                    cursor.execute("INSERT INTO autor_fuente (autor_id, fuente_id) VALUES (%s, %s)", 
                                (autor_id, fuente_id))

            # Manejar asignaturas
            asignaturas_ids = [int(id) for id in request.form.getlist('asignaturas')]
            
            for asignatura_id in asignaturas_ids:
                cursor.execute("INSERT INTO fuente_asignatura (fuente_id, asignatura_id) VALUES (%s, %s)",
                            (fuente_id, asignatura_id))
            conn.commit()
            flash('Fuente creada exitosamente', 'success')
            return redirect(url_for('admin_dashboard'))
        except Exception as e:
            conn.rollback()
            flash(f'Error al crear: {str(e)}', 'danger')
        finally:
            cursor.close()
            conn.close()
                   

    # Obtener tipos para el formulario
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT * FROM tipos_fuente")
        tipos = cursor.fetchall()
        return render_template('nueva_fuente.html', tipos=tipos)
    finally:
        cursor.close()
        conn.close()

# Logout
@app.route('/admin/logout')
def admin_logout():
    session.clear()
    return redirect(url_for('admin_login'))

if __name__ == '__main__':
    app.run(debug=True)