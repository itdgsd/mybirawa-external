<p align="center"><a href="https://laravel.com" target="_blank"><img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="400"></a></p>


## About this API

- create database externaldb
- sesuaikan di environment (.env)bagian [host, port, username, password]

Command: (1st time run)
- cd [directory location]
- Composer install
- composer require intervention/image
- php artisan vendor:publish --provider="Intervention\Image\ImageServiceProviderLaravelRecent"

Migrating Database:
- php artisan migrate:fresh --seed
- php artisan db:seed --class=IndoRegionProvinceSeeder      # Import data provinsi
- php artisan db:seed --class=IndoRegionRegencySeeder       # Import data kota/kabupaten

Running when using php:
- php artisan serve


Regards

Jordan Tua Yosephindo