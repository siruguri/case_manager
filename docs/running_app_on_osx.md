# Accessing The Code 

The application is written as a "Ruby on Rails" app. All the code and data files are in a single folder - on your
machine, this is `Desktop -> apps -> case_manager`

## Using Terminal

To get to this folder, and to start the application, you have to start an application called `Terminal` - use Spotlight to find and start it on your Mac.

If `Terminal` doesn't automatically open a blank screen, open one using `Shell -> New Window -> Basic`, or by using the keyboard shortcut `Command-N`

In the screen that opens up, called the **command line interface** aka **the shell**, type in the following:

    cd Desktop/apps/case_manager
    rails server

This should give you a message that looks something like this:

    => Booting Thin
    => Rails 4.1.5 application starting in development on http://0.0.0.0:3000
    => Run `rails server -h` for more startup options
    => Notice: server is listening on all interfaces (0.0.0.0). Consider using 127.0.0.1 (--binding option)
    => Ctrl-C to shutdown server
    Thin web server (v1.6.2 codename Doc Brown)
    Maximum connections set to 1024
    Listening on 0.0.0.0:3000, CTRL+C to stop

Now you should be able to open your browser, and in the address bar, type in `http://localhost:3000`. This should show you the app.
