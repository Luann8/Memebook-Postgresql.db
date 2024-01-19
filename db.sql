-- Tabela de Memes
create table memebook as (
    meme_id serial primary key,
    meme_url varchar(255) not null,
    uploader_name varchar(100) not null,
    upload_date timestamp default current_timestamp
);

-- Tabela de Likes
create table meme_likes as (
    like_id serial primary key,
    meme_id int references memebook(meme_id),
    liker_name varchar(100) not null,
    like_date timestamp default current_timestamp
);

-- Tabela de Comentários
create table meme_comments as (
    comment_id serial primary key,
    meme_id int references memebook(meme_id),
    commenter_name varchar(100) not null,
    comment_text text not null,
    comment_date timestamp default current_timestamp
);

-- Exemplo de Inserção de Meme
insert into memebook (meme_url, uploader_name) values
    ('https://th.bing.com/th/id/OIP.h1MhlRthdd-Vzk2FESKzvgAAAA?rs=1&pid=ImgDetMain', 'MemeMaster123');

-- Exemplo de Like em um Meme
insert into meme_likes (meme_id, liker_name) values
    (1, 'MemeFanatic456');

-- Exemplo de Comentário em um Meme
insert into meme_comments (meme_id, commenter_name, comment_text) values
    (1, 'ComicCommenter789', 'Haha, this is hilarious!');

-- Consulta para Verificar Meme e suas Interações
select
    m.meme_id,
    m.meme_url,
    m.uploader_name,
    count(l.like_id) as total_likes,
    count(c.comment_id) as total_comments
from
    memebook m
left join
    meme_likes l on m.meme_id = l.meme_id
left join
    meme_comments c on m.meme_id = c.meme_id
group by
    m.meme_id, m.meme_url, m.uploader_name;
