let data;

function preload() {
  data = loadTable('data/giss-data-july-17-2023.csv', 'csv', 'header');
}

function setup() {
  createCanvas(400, 400);

  // Get first row
  let row = data.getRow(0);
}

function draw() {
  background(0);
  translate(width / 2, height / 2);
  noFill();
  stroke(255);
  strokeWeight(4);

  circle(0, 0, 100);
  fill(255);
  noStroke();
  text("0°", 54, 0);
}
