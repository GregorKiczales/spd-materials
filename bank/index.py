
import os
import json
import re 

from yattag import Doc
from yattag import indent

SRC = '/home/www/htdocs/cs-110/bank'
WWW = '/home/www/htdocs/cs-110/bank'

DB   = os.path.join(SRC, 'index.json')

HOST = 'cs110.students.cs.ubc.ca'

DIR = 'bank'

CODE_FILE_BASE   = os.path.join('https://', HOST, DIR)

GREEN_CIRCLE  = os.path.join(CODE_FILE_BASE, 'green_circle.png')
BLUE_SQUARE   = os.path.join(CODE_FILE_BASE, 'blue_square.png')
BLACK_DIAMOND = os.path.join(CODE_FILE_BASE, 'black_diamond.png')


doc, tag, text, line = Doc().ttl()

def main():
    write_page(generate_page(read_db()))

def read_db():
    with open(DB, 'r') as f:
        return json.load(f)

def write_page(doc):
    with open(os.path.join(WWW, 'index.html'), 'w') as out:
        out.write(doc.getvalue())


def generate_page(problems):
    doc.asis('<!DOCTYPE html>')
    
    with tag('html'):
        
        with tag('head'):
            doc.stag('link', href='https://' + HOST + '../spd-style.css', rel='stylesheet', type='text/css')
        with tag('title'):
            text('Problem Bank')

        with tag('body'):
            preface()
            with tag('table', valign='top', halign='left', border='1', cellpadding='5', width='100%'):
                colgroup()
                header_row()
                for p in problems:
                    problem_row(p)

    return doc

def preface():
    with tag('h3'):
        text('Problem Bank')
        
    with tag('p'):
        text('Problems numbered P1, P2... are practice problems.')        
        text(' ')
        text('Problems numbered NV1, NV2... are problems from the edX numbered videos.')
       
    with tag('p'):
        text('Problems that have an autograder are marked in the first column.')        

    with tag('p'):
        difficulty('Green')
        text(' Easy   ')
        difficulty('Blue')
        text(' Medium   ')
        difficulty('Black')
        text(' Hard   ')

def colgroup():
    with tag('colgroup'):
        doc.stag('col', style='width: 20%')
        doc.stag('col', style='width: 10%')
        doc.stag('col', style='width: 15%')
        doc.stag('col', style='width: 55%')

def header_row():
    with tag('tr'):
        with tag('th'):
            text('Problem Number')
        with tag('th'):
            text('Difficulty')
        with tag('th'):
            text('Requires lectures')
        with tag('th'):
            text('Name and files')

def problem_row(p):
    with tag('tr', 'id=' + p["module"] + '_p_' + str(p["setNumber"])):
        with tag('td'):
            if (p["kind"] == 'Practice'):
                text(p["module"] + ' P' + str(p["setNumber"]))
            else:
                text(p["module"] + ' NV' + str(p["setNumber"]))

            m = re.search('(.*?)-starter.rkt$', p["codeFiles"][0])
            
            if( m and m.group(1) and os.path.exists(os.path.join(SRC, m.group(1) + '-grader.rkt'))):
                doc.stag('br')
                doc.stag('br')
                text('Has Grader')

        with tag('td'):
            difficulty(p["difficulty"])
        with tag('td'):
            text(p["lecture"])
        with tag('td'):
            with tag('p'):
                text(p["name"])
            with tag('p'):                
                text(p["description"])
            with tag('p'):
                for f in p["codeFiles"]:
                    with tag('a', 'href=' + CODE_FILE_BASE + '/' + f):
                        text(f)
                        doc.stag('br')


def difficulty(d):
    file, desc = '', ''
    if (d == 'Green'):
        file = GREEN_CIRCLE
        desc = 'easy'
    elif (d == 'Blue'):
        file = BLUE_SQUARE
        desc = 'medium'
    else:
        file = BLACK_DIAMOND
        desc = 'hard'

    doc.stag('img', src=file, title=desc)




PREFACE = 'do do do'

main()
