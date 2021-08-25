import string
import random

alpha_numerals = string.ascii_letters + string.digits

def generate_random_string(string_length=6)->str:
    random_string = ''
    for _ in range(string_length):
        random_string = random_string + random.choice(alpha_numerals)
    return random_string