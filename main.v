module main

import veb
import os

pub struct Context {
  veb.Context
}

pub struct App{
  veb.StaticHandler
}

fn main() {
    mut app := &App{}

    mut port := 5500

    if os.args.len > 1 {
        if !os.args[1].is_int() {
            print('Invalid port given: '+os.args[1]+', using default port '+ port.str()+'\n')
        } else { port = os.args[1].int() }
    }

    // Maximum port for veb
    if port > 65535 {
        port = 5500
        print('Invalid port given: '+os.args[1]+', using default port '+ port.str()+'\n')
    }

    app.handle_static('./', true) or {
        panic(err)
    }

    print('Starting dev server at localhost:'+port.str()+'\n')
    veb.run_at[App, Context](mut app, veb.RunParams{ host: 'localhost', port: port, show_startup_message: false })!
}
