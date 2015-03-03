import csv
import sys

if len(sys.argv) != 3:
    sys.exit("Usage: $ python results2csv.py file_in file_out")

file_in = sys.argv[1]
file_out = sys.argv[2]

if file_in == file_out:
    sys.exit("Cannot overwrite input file. Provide different name for output.")

with open(file_in, 'r') as f:
    data = f.readlines()

clusters = [] # Containter for clusters

### Read each cluster
cluster = []
for line in data:
    if line[:3] == '---':
        clusters.append(cluster)
        cluster = []
    else:
        cluster.append(line.strip())

### Write to file
with open(file_out, 'w') as f:
    writer = csv.writer(f)
    for row in clusters:
        writer.writerow(row)