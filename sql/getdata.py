import requests
import random


def get_random_date():
    year = random.randrange(2015, 2025)
    month = random.randrange(1, 13)
    day = random.randrange(1, 29)
    return f'{year}-{month}-{day}'
count = 5

response = requests.get(f'https://randomuser.me/api/?inc=name,email,phone,location&nat=us&results={2 * count}')

data = response.json()['results']
  
# print(f"Response: {data}")
# ('Jonathan', 'McCoy', '7556 Elgin St', 'Irving', 'Iowa', '47125',
# '(594) 273-5475', 'jonathan.mccoy@example.com', 'Roberta', 'Elliot',
# '2023-09-21', TRUE)

students = []
for i in range(0, 2 * count, 2):
    student = []
    student.append(data[i]['name']['first'])
    student.append(data[i]['name']['last'])
    student.append(f'{data[i]['location']['street']['number']} {data[i]['location']['street']['name']}')
    student.append(data[i]['location']['city'])
    student.append(data[i]['location']['state'])
    student.append(str(data[i]['location']['postcode']))
    student.append(data[i]['phone'])
    student.append(data[i]['email'])
    student.append(data[i + 1]['name']['first'])
    student.append(data[i]['name']['last'])
    student.append(get_random_date())
    student.append('TRUE')
    students.append(tuple(student))

print(students)