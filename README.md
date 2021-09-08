[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black) [![Build Server](https://github.com/ankit435/murls/actions/workflows/build_server.yml/badge.svg)](https://github.com/ankit435/murls/actions/workflows/build_server.yml) [![Build Flutter](https://github.com/ankit435/murls/actions/workflows/buid_apk.yml/badge.svg)](https://github.com/ankit435/murls/actions/workflows/buid_apk.yml)

![logo](https://cdn.hashnode.com/res/hashnode/image/upload/v1630476984691/OVsnclG8F.jpeg)


# Murls

Murls is an advanced URL Re-director capable of handling huge number of URLs with some advanced redirection capabilities.

It is not just a simple server redirecting URLs, or a simple app creating URLs. Actually, it is a combination of all including a **superfast Web Server**, **a secure Mobile App** and **a handy Chrome Extension**. 

  
## Screenshots

### Web Extension

![web extension screenshot](https://cdn.hashnode.com/res/hashnode/image/upload/v1630479067377/RzvQV7OufX.png)

### Mobile App

![mobile app screenshot](https://cdn.hashnode.com/res/hashnode/image/upload/v1630481612941/c_Yj7IcaB.png?auto=compress,format&format=webp)


### Running Server

![server_image](https://user-images.githubusercontent.com/55396651/132455426-319bb8d7-16b2-4313-9dfd-4fd6884766ab.jpg)

  
## Tech Stack

<table>
<thead>
<tr>
<td><strong>Server</strong></td><td><strong>Mobile</strong></td><td><strong>Web Extension</strong></td></tr>
</thead>
<tbody>
<tr>
<td>Django, Django Rest Framework</td><td>Flutter</td><td>Preact</td></tr>
<tr>
<td>Nginx</td><td>Flutter App_Auth</td><td>Material-UI</td></tr>
<tr>
<td>PostgreSQL</td><td>Flutter Secure Storage</td><td>React Icons</td></tr>
<tr>
<td>Redis</td><td>FL_Chart</td><td>-</td></tr>
</tbody>
</table>

  
## Extra Features

### 1.  Actually Fast

We said **_superfast_**. There's a reason for that!

We implemented a new concept called _boosted urls_ which is faster than the normal urls (those not boosted by Murls). Boosted URLs use [Redis](https://redis.io/) to get the location of the redirected URL.
This process is much faster than the normal querying of the PostgreSQL database.

### 2. Metrics and Details

The Murls Server is tracks the details of the request and asynchronously saves those details (along with the IP Address and Time) into the database for a particular URL.

The Murls Mobile App takes care of displaying those details to the user in a detailed graph and the number of visits for that URL.

### 3. Auth0 Authentication

For a smooth and to have a better track of the users in the organization, we used Auth0 for handling authentication and user management.

All the apps, including the server, the mobile app, and the web extension use auth0 as a single source of truth for managing auth.

## Authors

- [@ankit435](https://www.github.com/ankit435)
- [@aditya-mitra](https://github.com/aditya-mitra)

## License

```
 MIT License

Copyright (c) 2021 ankit435

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

```
