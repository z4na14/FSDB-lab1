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
    and birthdate != '29-02-1970'
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
    signature,
    null,
    to_date(pub_date, 'DD-MM-YYYY'),
    edition,
    notes
    from fsdb.acervus
    where
    signature is not null
    and edition is not null


--Loans
insert into loan(loanId, copy)
  select distinct
    null,
    signature,
  from fsdb.acervus
  where
    and signature is not null
and insert into loan(users, loanDate, ReturnDate)
  select distinct
    user_id,
    to_date(date_time, 'DD-MM-YYYY'),
    to_date(return,  'DD-MM-YYYY')
  from fsdb.loans
  where
    date_time is not null
    and return is not null
;

--Reservation
insert into Reservation(ReservationId, copy, reservationDate)
  select distinct
    null,
    signature,
    null,
  from fsdb.acervus
  where
    signature is not null
  
  and insert into Reservation(users)
  user_id
  from fsdb.loans
  where 
    user_id is not null
;

--Sanction
insert into sanction(users)
  select distinct
    user_id
  from fsdb.loans
  where
    user_id is not null
;

--Comments
insert into comments(users, text)
  select distinct
    user_id,
    post
  from fsdb.loans
  where
  user_id is not null
  and post is not null
;

--Bibus
insert into bibus
  select distinct
    plate,
    to_date(last_itv, 'DD-MM-YYYY'),
    to_date(next_itv, 'DD-MM-YYYY')
  from fsdb.busstops
  where
  plate is not null
  and last_itv is not null
  and next_itv is not null
;

--Drive
insert into driver
  select distinct
    lib_fullname,
    lib_passport,
    lib_phone,
    lib_email,
    to_date(cont_start, 'DD-MM-YYYY'),
    to_date(cont_end, 'DD-MM-YYYY'),
    null
  where
  lib_fullname is not null
  and lib_passport is not null
  and lib_phone is not null
  and lib_email is not null
  and cont_start is not null
  and cont_end is not null
  ;

--Routes
insert into Routes
  select distinct
  route_id,
    null
  from fsdb.busstops
  where
    route_id is not null
;

insert into municipality
  select 
    town,
    population,
    has_library
  from fsdb.busstops
  where
    town is not null
    and population is not null
    and has_library is not null
  ;

insert into municipal_library(municipality, address)
  select distinct
    town,
    address
  from fsdb.busstops
  where
    town is not null
    and address is not null
;

insert into route_municipality
  select distinct
    route_id,
    town
  from fsdb.busstops
  where
    route_id is not null
    and town is not null
;

insert into bibus_route
  select distinct
    plate,
    route_id
  from fsdb.busstops
  where
    plate is not null
    and route_id is not null
;


  
  




    


