import sys

import bottle
from bottlereact import BottleReact
from livereload import Server

PROD = False
DEBUG = True
RELOAD = True
LIVE_RELOAD = RELOAD
app = bottle.Bottle()
br = BottleReact(app, prod=PROD, verbose=True)


@app.get('/')
def root():
    return br.render_html(
        br.HelloWorld({'name': 'World'})
    )


@app.post('/login')
def login():
    return


def run():
    bottle.debug(DEBUG)
    if LIVE_RELOAD:
        server = Server(app)
        # server.watch
        server.serve(port=8081,
                     host='0.0.0.0')
    else:
        bottle.run(
            app=app,
            host='0.0.0.0',
            port='8081',
            reloader=RELOAD,
            server='auto'
        )


if __name__ == '__main__':
    run()
