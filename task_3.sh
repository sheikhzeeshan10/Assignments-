#!/bin/bash

. ./config.cfg
directory='~/Music/Task_3'

query_1=(
"SELECT invoice.invoice_id, customer.first_name, customer.last_name, customer.company, invoice.invoice_date FROM invoice join customer on customer.customer_id=invoice.customer_id WHERE EXTRACT(YEAR FROM invoice.invoice_date)=2011 ORDER BY invoice.invoice_date"
)

query_2=(
"SELECT invoice.invoice_id, customer.customer_id, invoice_line.track_id, artist.name, album.title, track.name, invoice.invoice_id, invoice.invoice_date FROM invoice join customer on customer.customer_id=invoice.customer_id join invoice_line on invoice_line.invoice_id=invoice.invoice_id join track on track.track_id=invoice_line.track_id join album on album.album_id=track.album_id join artist on artist.artist_id=album.artist_id WHERE EXTRACT(YEAR FROM invoice.invoice_date)=2012 ORDER BY invoice.invoice_id"
)


for i in "${!queries[@]}"
do
PGPASSWORD=$password psql -h $host -d $name -U $username <<EOF
	\copy (${queries[$i]}) to '${directory}/query_${i}.csv' with CSV HEADER;

