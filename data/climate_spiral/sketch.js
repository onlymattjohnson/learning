let data;

function preload() {
  data = loadTable('data/giss-data-july-17-2023.csv', 'csv', 'header');
}

function setup() {
  createCanvas(400, 400);
  console.log(data.getRowCount());
}

function draw() {
  background(220);
}
