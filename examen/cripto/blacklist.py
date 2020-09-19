import hashlib 
text = "HOLA"
hash_object = hashlib.md5(text.encode())
md5_hash = hash_object.hexdigest()
# print(md5_hash)

with open('./black.txt') as f:
    for line in f:
        # print(line)
        hash_object = hashlib.md5(line.encode())
        md5_hash = hash_object.hexdigest()
        # print(md5_hash)
        if (md5_hash == '9e72b9ef7d94bd8783214fe38a3b43bd'):
            print("=========================================")
            print(md5_hash)
