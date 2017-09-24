# BVly

URL Shortner for your eyes!

This application will help you manage URLs that are just too long.

## Usage & Install

* Clone the repository

* Run `bundle install` then `rails s`

* Run `cp env.sample .env` then change environment variables accordingly.

* or just visit [this link](https://bvly.herokuapp.com/) to see the working application.

## Requirements && Features

### Core Features:

* Any user is able to generate a shorten URL.

* Shorten url takes the user back to the original link.

* Same URL returns the same shortened URL.

* Users are able to see the top 100 board with the most frequently accessed URLs.

### Extra Features:

* Signed up user is able to generate a shorten URL and keep track of it.

* Signed up user is able to generate their own unique shorten URLs.

* A Bot that auto populates the DB.

## Implementation

### Key/Value : ID/URL:

In order to keep track of the generated URLs, database stores the full string of original URLs. These are easily and quickly accessbile via the primary key(ID) or the encoded Key of the table.

### Shortest Possible Length:

In order to achieve this requirement, the base 36 string conversion of the primary key was used.

The requirement asked for the `shortest possible length` and the base64 conversion is more suitable to achieve this goal than base36. However, base64 usually contains upper and lower cases of the alphabets along with special character, which the trade off for shortening the url did not seem to be worth more than the lost of user experiences.

  > Ex.1) the lower and uppercase will make it difficult for a person to read out loud for someone else.

  > Ex.2) Looks much cleaner when all aphabets are in same consistent form.

Also, Ruby's core library already provides very simple and nice conversion method(`to_s(36)`). Why invent the wheel again? It wouldn't be significantly shorter, and base36 also have benefits mentioned above.

However, to represent the method of making shorter URLs, below code and explanation was added.

#### Encoding:
```ruby
BASE_62_VALUES = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
def encode_base(num, base = 62)
  return BASE_62_VALUES[0] if num == 0
  result = ''
  while num > 0
    remainder = num % base
    result.prepend(BASE_62_VALUES[remainder])
    num = (num / base).floor
  end
result
end
```

The above code translates a number into the base62 format. If more characters such as `-`, `_` etc. were added, it is very possible to easily create base64 or more/less.

1. The first `BASE_62_VALUES` defines the characters that will be used. (Total of 62 chars)

2. If the input number is equal to 0, return 0

3. Set the initial `''` string that will be the end result.

4. Divide the input `num` by `base` and record the `remainder`. (Used the modulo for this)

5. Use that remainder as an index of the `BASE_62_VALUES` and add to the `result` string

6. Change the `num` value to the quotient of `num / base`

The fundamental behind the above method is that, when conveting to a different base, we want to figure out how many times the `62` fits inside that number.

```
Ex).
In order to convert a number 12233,

  1. 12233 / 62 = 197, remainder is 19'

  2. 197 / 62 = 3, remainder is 11

  3. 3 / 62 = 0, remainder is 3

Therefore,

(3*62^2) + (11*62^1) + (19*62^0) = 12233
```
Which equals to `dlt` in Base62 conversion.

#### Decoding:
```ruby
def decode_base(value, base = 62)
  base_10_num = 0
  power = 0
  value.reverse.each_char do |char|
    num = BASE_62_VALUES.index(char)
    base_10_num += num * (base ** power)
    power += 1
  end
  base_10_num
end
```
1. Set the initial `power` and `base_10_num`

2. Find the index of the character of the `value.reverse`

3. Multiply the number found in the `BASE_62_VALUES` by the `base ** power`.

  > 0 + (19 * 62^0) --> letter is t
  > 19 + (11 * 62^1) --> letter is l
  > 197 + (3 * 62^2) --> letter is d

With the above method, one is able to be flexible about which base system one wants to use.

### Handling Duplicate URLs:

Instead of inserting a new record for an already existing URL, the matching URL will be searched by the indexced column and will return the data.

### Various Format of URL Detection:

There are multiple ways to write a same URL in terms of the end user.

> 1) `www.james-hwang.com`
> 2) `https://www.james-hwang.com`
> 3) `james-hwang.com`

All of the above redirect users to the same website. In order to detect a same URL, a method was needed to resolve this issue via regular expressions.

```ruby
  # Regex Used to detect and substitue URL
  /\Ahttp(s)?:\/\//.match(text) ? text : text.gsub(/\A(http(s)?:\/\/)?(www\.)?(.*)/,"http\\2://www.\\4")
```

Explanation:

1. `\A` matches the pattern in the beginning of the string.

2. `/\Ahttp(s)?:\/\//.match(text)` checks for http or https in the string.

3. if it matches, it will return `text`, else will `.gsub/\A(http(s)?:\/\/)?(www\.)?(.*)/,"http\\2://www.\\4")`

4. The first part of the `.gsub()`, `\A(http(s)?:\/\/)` will again check if there is `http//` or `https//`

5. The next part after the `?` mark will check for `www.`

6. The next part after the second `?` will match any characters.

7. Step 4,5,6 will be replaced by the `\2\`, `http` or `https` depending on the second paranethesis detection. The last part will be replaced by `\4\`, which is any characters after `.`

## Contact

91juhwang@gmail.com

[Portfolio](https://www.james-hwang.com)