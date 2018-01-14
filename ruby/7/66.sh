mongo 64 << EOF
db.artists.find({ area: 'Japan' }).count()
EOF
