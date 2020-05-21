# Installing and Configuring a Nginx Reverse Porxy for Jellyfin/Ombi/JF-Accounts on Windows WSL1/WSL2
## Requirements
### 1. Internet Access (it can be Wifi or Wired)
2. You need to have a Windows 10 Operating System
  - Both requirements for above should be self explanitory or you wouldnt be looking at this if you didnt already aquire them.
3. You Need to Install WSL1/WSL2
  - Please Reference below on how to install Windows WSL1 or WSL2 on Windows 10
				Video Guide [Click Here](https://youtu.be/ilKQHAFeQR0?t=84)
				Credit Goes to YT Account Windows Developer for the Quick Tutorial
				You Can Subscribe by [Clicking Here](https://www.youtube.com/channel/UCzLbHrU7U3cUDNQWWAqjceA)
				Text Guide [Click Here](https://pureinfotech.com/install-windows-subsystem-linux-2-windows-10/)
4. You Need a Linux OS installed from the Windows Store
  - Please Reference Below on how to install Windows WSL1 or WSL2 on Windows 10
						Credit Goes to YT Account Windows Developer for the Quick Tutorial
						You Can Subscribe by [Click Here](https://www.youtube.com/channel/UCzLbHrU7U3cUDNQWWAqjceA)
				Video Guide [Click Here](https://youtu.be/ilKQHAFeQR0)
				Text Guide [Click Here](https://ubuntu.com/tutorials/tutorial-ubuntu-on-windows#1-overview)
5. Configure Linux Distro
  - Please Reference to here on how to setup Linux distro once you have completed Step 3
			***THIS MAY TAKE SOME TIME TO LOAD PLEASE BE PATEINT DONT WORRY IT WILL Load!***
				Credit Goes to YT Account Windows Developer for the Quick Tutorial
				You Can Subscribe Here and View More Windows Tuts as Well [Click Here](https://www.youtube.com/channel/UCzLbHrU7U3cUDNQWWAqjceA)
				Video Guide [Click here](https://youtu.be/ilKQHAFeQR0?t=105)

6. Some type of Document Editor (Recommned Sublime Text 3)(Works with Just about every kind of scripting language with syntax checking)
  -Download Sublime Text Editor 3 here:
        [link to x64](https://download.sublimetext.com/Sublime%20Text%20Build%203211%20x64%20Setup.exe)
        [link to x64 Portable](https://download.sublimetext.com/Sublime%20Text%20Build%203211%20x64.zip)
        [link to x86](https://download.sublimetext.com/Sublime%20Text%20Build%203211%20Setup.exe)
        [link to x86 Portable](https://download.sublimetext.com/Sublime%20Text%20Build%203211.zip) 
7. And of course a microsoft account ie. @outlook.com @hotmail.com @live.com email account
### Things to Note
It might be worth while to install the new Windows Terminal in which you can switch between Windows Shell/CMD/Linux Distro/Bash Terminals all in one
	If you would like to see how to do so Please follow Below
		#### Installing New Windows AIO Terminal
			Download Terminal from Microsoft Store [Click Here](https://www.microsoft.com/store/productId/9N0DX20HK701)
			Credit goes to [T-Soln](https://www.youtube.com/channel/UCzDbMkDgqs9b43vZ5yeX0gQ)
			Video Tutorial [Click Here](https://www.youtube.com/watch?v=WmC5BQPSCsA)
			Credit goes to [Ben Stockton](https://helpdeskgeek.com/author/bstockton/)
			Text Tutorial [Click Here](https://helpdeskgeek.com/windows-10/how-to-install-use-the-new-windows-10-terminal/)
You'll need all of the above requirements Before Starting
***A SIDE NOTE IM USING THE LINUX DISTRIBUTION UBUNTU 20.04*** 
##Before We Start if you want to make it easier on yourself or your just a noob at linux use the all the recommended downloads i have put below. That way you can literally follow me word for word.
Download Terminal from Microsoft Store [Click Here](https://www.microsoft.com/store/productId/9N0DX20HK701)
Download Ubuntu 20.04 [Click Here](https://www.microsoft.com/en-us/p/ubuntu-2004-lts/9n6svws3rx71?activetab=pivot:overviewtab)
##Starting in WSL1 or WSL
		 Once you have made your user and are now at the terminal screen of your Linux Distribution.
##Installing PHP	
			1. Run these two commands (these two commands are going to install all your packages that may be out of date or old deb packages)
						```sudo apt-get updates```
						```sudo apt-get upgrades```
						
			2. Once Finished Run these two commands. These are going to install all the PHP packages that we need to run nginx. and then were checking the php packages to see which ones were installed.
				Again note im using the Ubuntu 20.04 Linux Distribution if your using any other types please go [Click Here] (https://computingforgeeks.com/how-to-install-php-on-ubuntu/)
				This will cover all other Ubuntu Distributions besides 20.04
						```sudo apt install php php-cli php-fpm php-json php-pdo php-mysql php-zip php-gd  php-mbstring php-curl php-xml php-pear php-bcmath```
						![Screenshot of Installation of PHP](https://i.imgur.com/1ukZrXz.png)
						```php --version```
						![Screenshot Check PHP Installed](https://i.imgur.com/iqIm79Z.png)
		#####Installing and Starting Nginx
			1. Run these commands Below 
						```sudo apt install nginx```
						```sudo service nginx start```
					These two commands will properly install nginx and start the service
						![Installing and Starting Nginx](https://i.imgur.com/o75TdzA.png)					
		#####Checking and Configuring our Network
			1. Wsl 2 uses a virtual switch to route traffic. We will need to obtain the IP address for the network interface. Please run command below
						```ip addr show```
						![Screenshot Check IP Adress on Local Machine](https://i.imgur.com/82T4wH0.png)					
			2. You Should Visit http://[yourIP] in your favorite browser and you should receive something similar to the below image.
					ie. http://192.168.1.114 (this would be where i would go on my machine)
						![Nginx Install Success Page](https://i.imgur.com/uVVNCGo.png)
##Setting up PHP-FPM
			1. The next steps is setting up the PHP-FPM processor. We need to get the unix sock file that the PHP-FPM service will listen on.

					```grep "listen =" /etc/php/7.4/fpm/pool.d/www.conf```
						You Should be returned with this ```output: listen = /run/php/php7.4-fpm.sock```
						![Add PHP7.4 Listening](https://i.imgur.com/uVVNCGo.png)
			2. Now Start the service with the code below
					```sudo service php7.4-fpm start```	
					![Add PHP 7.4 FPM Start](https://i.imgur.com/uVVNCGo.png)
			3. Now we need to modify the Nginx default server block settings. Type in your linux Distro
					```sudo nano /etc/nginx/sites-available/default```
         			![Opening Nano Script Editor]()
			4. Once in the Nano Editor. Add this text inside by either copy and pasting or typing it out.
			  ```location ~ \.php$ {
                 include snippets/fastcgi-php.conf;
 					![Nginx Install Success Page](https://i.imgur.com/uVVNCGo.png)
                 # Make sure unix socket path matches PHP-FPM configured path above
                 fastcgi_pass unix:/run/php/php7.4-fpm.sock;

                 # Prevent ERR_INCOMPLETE_CHUNKED_ENCODING when browser hangs on response
                 fastcgi_buffering off;
         		 }```	
         			![New Nano Configurations]()
         	5. Now Restart Nginx Server. This will allow it to load our new saved settings done above.
         	  ```sudo service nginx restart```
         	6. Now youve succesfully installed PHP on your WSL
## Configuring Nginx for Reverse Proxy on WSL1/WSL2 for Jellyfin Server
			1. Add the below line (in bold) to  nginx.conf by typing command
					```sudo nano /etc/nginx/nginx.conf```
					Then Replace the text below by either copy and pasting or Right Clicking on Your Mouse
					```user www-data;
					***master_process off;***
					worker_processes 4;```
					1. Then Pres CTRL+O(Letter O not #) Then RETURN (to save the file)
					2. Then Press Enter on the Keybaord
					3. Then CTRL+X to close the file
			2. type the command ```sudo nano/etc/nginx/sites-available/default``` to edit the Nginx Default site configuration
			3. Now add index.php to the line below
					Before
					```index index.html index.htm index.nginx-debian.html;```
					***After***
					```index **index.php** index.html index.htm index.nginx-debian.html;```
			4. Stay in that same file and make this edit now to the text line below
					BEFORE
					```# Add index.php to the list if you are using PHP
					    index index.html index.htm index.nginx-debian.html;

					   server_name _;
						 
						 location / {
						 	# First attempt to serve request as file, then
        				 	# as directory, then fall back to displaying a 404.
        				 	try_files $uri $uri/ =404;
						 }

        			     # pass PHP scripts to FastCGI server
        			     #
					     #location ~ \.php$ {
					     # include snippets/fastcgi-php.conf;
					     #
					     # # With php-fpm (or other unix sockets):
					     # fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
					     # # With php-cgi (or other tcp sockets):
					     # fastcgi_pass 127.0.0.1:9000;
					     #}```
					***EDITS TO BE MADE***   
					 1. Remove the # symbol from the lines of code below
					   ```location ~ \.php$ {```
					   ```include snippets/fastcgi-php.conf;```
					   ```fastcgi_pass 127.0.0.1:9000;```
					   ```}```
					  2. Change the ```server_name _; to server_name example.com www.example.com (ie. server_name movies4you.digital wwww.movies4you.digitalW 
					After
					```# Add index.php to the list if you are using PHP
					   index index.php index.html index.htm index.nginx-debian.html;

					   server_name example.com www.example.com;
						 
						 location / {
						 	# First attempt to serve request as file, then
        				 	# as directory, then fall back to displaying a 404.
        				 	try_files $uri $uri/ =404;
						 }

        			     # pass PHP scripts to FastCGI server
        			     #
					     location ~ \.php$ {
					     	include snippets/fastcgi-php.conf;
					     	
					     	# With php-fpm (or other unix sockets):
					     	# fastcgi_pass unix:/var/run/php/php7.4-fpm.sock;
					     	#  With php-cgi (or other tcp sockets):
					      	fastcgi_pass 127.0.0.1:9000;
					     }```
			5. Now Save and Exit the Document by doing the following:		
				1. Now Again CTRL+O and RETURN (to save the file)
				2. Prses CTRL+X (to exit out of nano editing)
			6. Now we need to further edit some PHP files. So type this command in your terminal
				```sudo nano /etc/php/7.4/fpm/pool.d/www.conf```
					1. Search the file with CTRL+W
					2. Then Type ```listen.allowed_clients```
						(it shoulld move your cursor to this line) ```;listen.allowed_clients = 127.0.0.1```
					3. Comment it out teh line by putting ; at the start of the line. So it should look like this in the end
						```;listen.allowed_clients = 127.0.0.1```
					4. Now still in the same document you need to search ```listen = /run/php/php7.4-fpm.sock```
						Again like above insert a ; before the line to comment the line above to look like this ```;listen = /run/php/php7.4-fpm.sock```
						1. Again CTRL+O and RETURN(Save the File Again)
						2. Again CTRL+X (Exit the Nano Editor)
			7. Now Were going to open the directory ```/etc/nginx/sites-available/default``` by typing command
						```sudo nano /etc/nginx/sites-available/default```
			8. Now Search for this line ```fastcgi_pass```			
				1. Now Again CTRL+O and RETURN (to save the file)
				2. Prses CTRL+X (to exit out of nano editing)
			9. Now we need to further edit some PHP files. So type this command in your terminal
				```sudo nano /etc/php/7.4/fpm/pool.d/www.conf```
					1. Search the file with CTRL+W
					2. Then Type ```listen.allowed_clients```
						(it shoulld move your cursor to this line) ```;listen.allowed_clients = 127.0.0.1```
					3. Comment it out teh line by putting ; at the start of the line. So it should look like this in the end
						```;listen.allowed_clients = 127.0.0.1```
					4. Now still in the same document you need to search ```listen = /run/php/php7.4-fpm.sock```
						Again like above insert a ; before the line to comment the line above to look like this ```;listen = /run/php/php7.4-fpm.sock```
						1. Again CTRL+O and RETURN (Save the File Again)
						2. Again CTRL+X (Exit the Nano Editor)
			10. Now you can test your Nginx default file by running this command ```sudo nginx -t```
##Allowing Ports Through Firewall if UFW is enabled
			1. Input Command ```cd```
			2. Input command ```sudo ufw status``` to see whats allowed through the firewall.
			3. Input command ```sudo ufw allow 'Nginx Full'```
			4. Input command ```sudo ufw delete allow 'Nginx HTTP'```
##DNS Propegation
			1. type in your terminal command ```sudo nano /etc/hosts```
			2. See what your fules says under ```# generateHosts = false```
			3. Write this down somewhere it will be useful in the next part of editing of our jellyfin nginx config
			 IE. Mine says this:
			 ```127.0.0.1       localhost
				127.0.1.1       DevilsCoders-GamingRig.localdomain      DevilsCoders-GamingRig```
			Meaning my nginx is pulling to localhost or otherwise known as 127.0.0.1
			5.So now we have to add a line for each sub domain were making lets say im using ombi+jellyfin+jf-accounts
				So im going to add this to it \
				(replace stream with what you want to call your sub url ie. jellyfin)
				(replace requests with what you want to call your sub url ie. jellyfin)
				(replace accounts with what you want to call your sub url ie. jelllyfin)
				(replace example.com with what your domain name is ie. movies4you.digital)
				(Replace the # after the : with your port of your running application. ie. jellyfins port is 8096 ie. 172.0.0.1:8096)
			 ```127.0.0.1:#	stream.example.com ```(jellyfin)
			 ```127.0.0.1:#	requests.example.com`` (obmi)
			 ```127.0.0.1:#	accounts.example.com```(jf-accounts)
			 So once ive added all my subdomain lines im set to move on to the next step.
			 	(Just a little tip. if your running multiple nginx confs i recommend putting a # after the sub url to and name the suburl. ie. 127.0.0.1	stream.mexample.com	#Jellyfin)
			 (Before)
			 # This file was automatically generated by WSL. To stop automatic generation of this file, add the following entry to />
			 # [network]
			 # generateHosts = false
			 127.0.0.1       localhost
			 127.0.1.1       DevilsCoders-GamingRig.localdomain      DevilsCoders-GamingRig
			 # The following lines are desirable for IPv6 capable hosts
			 ::1     ip6-localhost ip6-loopback
			 fe00::0 ip6-localnet
			 ff00::0 ip6-mcastprefix
			 ff02::1 ip6-allnodes
			 ff02::2 ip6-allrouters
			 (After)
			 	```# This file was automatically generated by WSL. To stop automatic generation of this file, add the following entry to />
			 	# [network]
			 	# generateHosts = false
			 	127.0.0.1       ip6-localhosT
			 	127.0.1.1       DevilsCoders-GamingRig.localdomain      DevilsCoders-GamingRig
			 	127.0.0.1:8096		stream.moovies4you.digital	#Jellyfin
			 	127.0.0.1:5000		requests.movies4you.digital	#Ombi
			 	127.0.0.1:8056		accounts.movies4you.digital	#JF-Accounts

			 	# The following lines are desirable for IPv6 capable hosts
			 	::1     ip6-localhost ip6-loopback
			 	fe00::0 ip6-localnet
			 	ff00::0 ip6-mcastprefix
			 	ff02::1 ip6-allnodes
			 	ff02::2 ip6-allrouters```
			 	(Again yours may differ depedning on your setup. Im Using wifi. Wired may look a bit different but its essentially the same changes have to be made.)
			6. Now once these changes have been made please CTRL+0 and RETURN (to save your hosts file)
			7. Then CTRL+X (To Exit out of nano editor on the /etc/hosts)
##Editing Nginx Configuration Files (The Most fun But Confusing)
	**A BIG THANKS TO nekocentral FOR THE NGINX CONF BASE**
		**You Can Find Him in the support Forums under @nekocentral:matrix.org**
	1. Input the Terminal command
		```sudo nano /etc/nginx/conf.d/example```
		(you can put anything you want where example.conf is. Though i recommend you use your subdomain that was linked before ie. stream.movies4you.digital.conf)
	2. Once you input that command it will open a blank file created in nano editor
	3. Copy and paste the entire text below
	```
		upstream subdomain.example.local {
        ip_hash;    #added ip hash algorithm for session persistency
        server 127.0.0.1:#;

}
server {
        listen *:80;
        listen [::]:80;
        server_name subdomain.example.com;
        server_name subdomain.local.exmaple.com;
        #redirect to https
        if ($scheme = http) {return 301 https://$server_name$request_uri;}

}
server {
        listen 443 http2 ssl;
        server_name subdomain.example.com;
        server_name subdomain.local.example.com;

        # Logging settings
        access_log /var/log/nginx/jellyfin_access.log;
        error_log /var/log/nginx/jellyfin_error.log;

        # SSL Settings
        ssl_certificate /mnt/nginx/ssl/example.com/cert.pem;
        ssl_certificate_key /mnt/nginx/ssl/example.com/key.pem;
        ssl_trusted_certificate /mnt/nginx/ssl/example.com/ca.pem;
        add_header Content-Security-Policy upgrade-insecure-requests;
        add_header Vary Upgrade-Insecure-Requests;
        include /etc/nginx/snippets/ssl.conf;

        location / {
                proxy_pass http://subdomain.example.local;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-Protocol $scheme;
                proxy_set_header X-Forwarded-Host $http_host;
                proxy_buffering off;
        }
        location /socket {
                proxy_pass http://subdomain.example.local/socket;
                proxy_http_version 1.1;
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;
                proxy_set_header X-Forwarded-Protocol $scheme;
                proxy_set_header X-Forwarded-Host $http_host;
        }
}

```
	4. Once thats pasted in you need to change it to specify your locations so change all the subdomains for whatever you edited in your /etc/hosts
		ie. stream.movies4you.digital #Jellyfin
		(thats my jellyfin so i need to edit all subdomains to stream)
		(then i need to edit all examples to my main domain ie. movies4you)
		(Then all the .com need to be changed to my .digital)
		(Then Change all the # to the port number you assigned to the app ie. my jellyfin port is 8096. So i change all the # to 8096)
	5. Now Remeber for every subdomain/app we need to make a new file. but ive made it simple just copy and paste the code above and change the info lsited above as well.
	6. Once you have made the required edits. CTRL+O and RETURN (to save)
	7. CTRL+X to Exit Nano
##Putting Our Config Live
	1. Disable or delete the default Welcome to NGINX page by entering the command below in terminal
		```sudo mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.disabled```
	2.  Now we need to test our configuration to make sure there are no errors. Again paste the below in terminal to check.
		```sudo nginx -t```
	3. If there are no error continue on. If there are error **STOP** **DO NOT CONTINUE**
			1. USE GOOGLE to figure this part out. REMEBER GOOGLE IS YOUR FRIEND.
	4. Again if no Errors write the command in terminal below.
		```sudo nginx -s reload```
##SSL Cert and Configuration
	1. Install Certbot by first running a few commands to enabled the universal repository.
		1. ```sudo apt-get update```
		2. ```sudo apt-get install software-properties-common```
		3. ```sudo add-apt-repository universe```
		4. ```sudo apt-get update```
	2. Now we need to make sure the correct python3 packages are installed by running this command
		```sudo apt install python3-acme python3-certbot python3-mock python3-openssl python3-pkg-resources python3-pyparsing python3-zope.interface```
	3. Now we input in the terminal ```sudo apt-get install certbot python3-certbot-nginx```
	4. Now we need to check our Nginx Configuration ```sudo nano /etc/nginx/sites-available/stream.movies4you.digital```
	5. Now we install the DNS Plugin again im using cloudlafer so were going to install the cloudflare plugin
		-if anyone has any other dns they can look up what the install guides are [HERE](https://certbot.eff.org/docs/using.html#dns-plugins)
	5. No go to [Cloudflares website] (https://www.cloudflare.com/ and login to your account)
	6. Go to the Tab Overview
	7. Scroll Down until You See the API Section it should be near the bottom
	8. Click Get your API token
	9. It should take you to a page where the first table has API Tokens and theres a blue button saying create token. **WE DO NOT WANT TO CLICK THIS ONE**
	   Go to the second table and Youll see API Keys. Do you See Global API Key thats the one we want. Click on the blue button to view
	   Type your passowrd in and make sure you do the captcha.
	   Then it will expose your key **DO NOT GIVE THIS TO ANYONE THIS IS VERY IMPORTANT THATS WHY WERE PUTTING IT IN A VERY SECURE LOCATION ON OUR COMPUTER**
	10. Now **Temproarily Save this somewhere**
	11. Again im using cloudflare+Nginx Install run my dns so ill be showing you how to install a cert with cloudflare+Nginx Certbot below
		1. We now have to run a few more commands in terminal to make sure no one will be able to acces our cloudflare accept the root user.
			1. ```sudo mkdir /root/.secrets```
			2. ```sudo chmod 0700 /root/.secrets/```
			3. ```sudo touch /root/.secrets/cloudflare.cfg```
			4. ```sudo chmod 0400 /root/.secrets/cloudflare.cfg```
		2. Now we have to edit the files
			1. type the command ```sudo nano /root/.secrets/cloudflare.cfg``` in terminal
			2. It should be blank add these lines
				```dns_cloudflare_email = "email@domain.com"
				   dns_cloudflare_api_key = "2018c330b45f4ghytr420eaf66b49c5cabie4"```
			3. Now Press CTRL+ O and Return (to save the file)
			4. Now Press CTRL+ X (To exit nano editor)
		3. Now request a wildcard cert from cloudflare and nginx with the command below
			(replace .domain.com with your domain)
			```sudo /usr/local/bin/certbot certonly --dns-cloudflare --dns-cloudflare-credentials /root/.secrets/cloudflare.ini -d domain.com,*.domain.com --preferred-challenges dns-01```
		4. Now We need to Configure our .conf file we made earlier in /etc/nginx/conf.d/subdomain.domain.com.conf	ie.  /etc/nginx/conf.d/stream.movies4you.digital.conf
		5. Once Opened make sure the ssl certs are correctly linked in the .conf file
			```listen 443 ssl; # managed by Certbot
    		   ssl_certificate /etc/letsencrypt/live/subdomain.domain.com/fullchain.pem; # managed by Certbot
		       ssl_certificate_key /etc/letsencrypt/live/subdomain.domain.com/privkey.pem; # managed by Certbot
   			   include /etc/letsencrypt/options-ssl-nginx.conf; # managed by Certbot
    		   ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem; # managed by Certbot```
    	6. Once you verified everything looks correct. You can continue to the final step
##Start Nginx & Check
	1. Now type in the terminal ```sudo service nginx -t```
	2. If no errors run command ```sudo nginx -s reload``` to reload nginx.
	3. Open your favorite browser and type in 127.0.0.1:8096 or localhost:8096 or https://subdomain.example.com:8096 ie. https://stream.movies4you.digital:8096 make sure everything is correctly working
	4. Profit and Enjoy
