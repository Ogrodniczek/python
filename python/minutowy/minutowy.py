import os

strip = []
dane = []
tabela = []
tabela2 = []

pliki = os.listdir('pliki')

def splitStrip(plik, strip, dane):
    linestring = open('pliki/'+plik).readlines()
    strip = []
    dane = []
    for line in linestring:
        line = line.rstrip('\n')
        strip.append(line)
    for i in range(0,len(strip)):
        dane.append(strip[i].split('='))
    return dane

def errorTest():
    for plik in pliki:
        tabela = splitStrip(plik,strip,dane)
        for i in range(0,len(tabela)):
            tabela2 = tabela[i]
            for j in range(0, len(tabela2)):
                if tabela2[j] == 'error':
                    return '''<script>\nwindow.onload = function() {\nvar
                    currentColor = "red";\nsetInterval(function() {\n
                    document.body.style.backgroundColor =
                    currentColor;\ncurrentColor = currentColor ==="red" ?
                    "black" : "red";\n}, 1000);\n};\n</script>\n'''
def kolorki(wynik):
    if wynik == 'running':
        return '<td bgcolor="#00CC00">' + wynik + '</td>'
    elif wynik == 'done':
        return '<td bgcolor="0099CC">' + wynik + '</td>'
    elif wynik == 'error':
        return '<td bgcolor="FF0000">' + wynik + '</td>'
    else:
        return '<td>' + wynik + '</td>'


file = open('output.html','w+')
file.write('<html>\n')
file.write('<head>\n')
file.write('<title>Minutowe Tabelki</title>\n')
file.write('</head>\n')
file.write('<body>\n')

for plik in pliki:
    tabela = splitStrip(plik, strip, dane)
    file.write('''<table border="1" align="left" style="margin-left:50px">\n''')
    for i in range(0,len(tabela)):
        file.write('<tr>')
        tabela2 = tabela[i]
        for j in range(0,len(tabela2)):
            file.write(kolorki(tabela2[j]))
        file.write('</tr>\n')
    file.write('</table>\n')

file.write('</body>\n')
file.write('</html>')
file.close()
