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

def kolorki(wynik):
    if wynik == 'running':
        return '<td bgcolor="#33cc33">' + wynik + '</td>'
    elif wynik == 'done':
        return '<td bgcolor="006699">' + wynik + '</td>'
    elif wynik == 'error':
        return '<td bgcolor="cc0000">' + wynik + '</td>'
    else:
        return '<td>' + wynik + '</td>'


file = open('output.html','w+')
file.write('<html>\n')
file.write('<head>\n')
file.write('<link href="css/style.css" rel="stylesheet" type="text/css">\n')
file.write('<title>Minutowe Tabelki</title>\n')
file.write('</head>\n')
file.write('<body>\n')
file.write('<div class="bloczek">\n')

for plik in pliki:
    tabela = splitStrip(plik, strip, dane)
    file.write('<table>\n')
    for i in range(0,len(tabela)):
        file.write('<tr>')
        tabela2 = tabela[i]
        for j in range(0,len(tabela2)):
            file.write(kolorki(tabela2[j]))
        file.write('</tr>\n')
    file.write('</table>\n')

file.write('</div>')
file.write('</body>\n')
file.write('</html>')
file.close()
