set echo off
clear screen

--Users
insert into users
  select distinct
    user_id,
    surname1||surname2||name,
    passport,
    to_date(birthdate, 'DD-MM-YYYY'),
    town,
    address,
    email,
    phone
  from fsdb.loans
  where
    user_id is not null
    and name is not null
    and surname1 is not null
    and passport is not null
    and birthdate is not null
    and town is not null
    and address is not null
    and phone is not null
  ;


--Editions
insert into editions
  select distinct
    isbn,
    publisher,
    main_language,
    other_language,
    to_date(pub_date, 'DD-MM-YYYY'),
    extension,
    series,
    pub_country,
    dimensions,
    other_authors
  from fsdb.acervus
  where
    isbn is not null
    and publisher is not null
    and main_language is not null
    and pub_date is not null
  ;

--Books
insert into books
  select distinct
    title,
    alt_title,
    main_author,
    other_authors,
    edition,
    national_lib_id
  from fsdb.acervus
  where
    title is not null
    and main_author is not null
    and edition is not null
    and national_lib_id is not null
  ;

--Copies
insert into copies
  select distinct
    


