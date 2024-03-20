```
Table users {
  id integer [primary key]
  username varchar
  password varchar
  role varchar
  status integer
  created_at timestamp
  updated_at timestamp
}

Table cards {
  id integer [primary key]
  status integer
  creator integer
  updater integer
  created_at timestamp
  updated_at timestamp
}

Table layers_on_card {
  id integer [primary key]
  name varchar
  card_id integer
  layer_id integer
  layer_type string
  status integer
  creator integer
  updater integer
  created_at timestamp
  updated_at timestamp
}

Table images {
  id integer [primary key]
  name varchar
  url varchar
}

Table texts {
  id integer [primary key]
  content text
  is_long bool
  font varchar
  color varchar
  size integer
  text_align varchar
  vertical varchar
  text_type varchar
}

Table events {
  id integer [primary key]
  content varchar
  status integer
  creator integer
  updater integer
  created_at timestamp
  updated_at timestamp
}

Table categories {
  id integer [primary key]
  event_id integer
  content varchar
  status integer
  creator integer
  updater integer
  created_at timestamp
  updated_at timestamp
}

Table wishes {
  id integer [primary key]
  category_id integer
  content text
  status integer
  creator integer
  updater integer
  created_at timestamp
  updated_at timestamp
}


Ref: layers_on_card.card_id > cards.id
Ref: layers_on_card.layer_id - images.id
Ref: layers_on_card.layer_id - texts.id

Ref: events.id < categories.event_id
Ref: categories.id < wishes.category_id

Ref: events.creator > users.id
Ref: categories.creator > users.id
Ref: wishes.creator > users.id
Ref: layers_on_card.creator > users.id
```

