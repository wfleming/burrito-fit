README
======

Getting Started
---------------

Run `./bin/bootstrap`

Check local configuration in `config/env.yml`: some keys may need to be
customized locally (such as API keys for a FitBit app: see next section)


Local Tunnel for local testing
------------------------------

Proper testing of FitBit subscribers requires your app be open to the public
Internet: suggested way of doing this is to use ngrok:

    $ brew install ngrok
    $ ngrok  # this will run in the foreground with status: use a new shell
    $ foreman start

At https://dev.fitbit.com, you'll want to create an app with settings like:

* Application Name: BurritoFitYOURNAMEDev
* Application Website: https://YOURNAMEburrito.ngrok.com
* Organization Website: https://YOURNAMEburrito.ngrok.com
* App Type: Browser
* Callback URL: https://YOURNAMEburrito.ngrok/oauth/callback
* Access Type: Read-only
