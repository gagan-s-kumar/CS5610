server {
        listen 80;
        listen [::]:80;

        root /home/gagan/www/hw01.gaganandkumar.com;

        index hw01.html;

        server_name hw01.gaganandkumar.com;

        location / {
                # First attempt to serve request as file, then
                # as directory, then fall back to displaying a 404.
                try_files $uri $uri/ =404;
        }
}
