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
Internet: suggested way of doing this is to use http://localtunnel.me:

    npm install -g localtunnel
    lt --port 5000 --subdomain YOURNAMEburrito
    foreman start

At https://dev.fitbit.com, you'll want to create an app with settings like:

* Application Name: BurritoFitYOURNAMEDev
* Application Website: https://YOURNAMEburrito.localtunnel.me
* Organization Website: https://YOURNAMEburrito.localtunnel.me
* App Type: Browser
* Callback URL: https://YOURNAME-burritos.localtunnel.me/oauth/callback
* Access Type: Read-only
