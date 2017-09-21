# BVly

URL Shortner for your eyes!

This application will help you manage URLs that are just too long.

## Usage & Install

* Clone the repository

* Run `bundle install` then `rails s`

* or just visit [this link](www.) to see the working application.

## Requirements && Features

* Any user is able to generate a shorten URL.

* Shorten url takes the user back to the original link.

* Same URL returns the same shortened URL.

* Users are able to see the top 100 board with the most frequently accessed URLs.

#### Extra Features

* Signed up user is able to generate a shorten URL and keep track of it.

* Signed up user is able to generate their own unique shorten URLs.

* A Bot that auto populates the DB.

## Implementation

#### Key/Value : ID/URL

In order to keep track of the generated URLs, database stores the full string of original URLs. These are easily and quickly accessbile via the primary key(ID) of the table.

#### Shortest Possible Length

In order to achieve this requirement, the base 32 string conversion of the primary key was used.

The primary key will ensure the look up and storage of the data, while Base 32 conversion shortens and make the URL look prettier.

The requirement asked for the `shortest possible length` and the base 64 conversion is more suitable to achieve this goal instead of base32. However, base 64 contains upper and lower cases of the alphabets, and the trade off for shortening the url did not seem to be worth more than the lost of user experiences.

  > Ex.1) the lower and uppercase will make it difficult for a person to read out loud for someone else.

  > Ex.2) Looks much cleaner when all aphabets are in same consistent form.

#### Handling Duplicate URLs

Instead of inserting a new record for an already existing URL, the matching URL will be searched by the indexced column and will return the data.

