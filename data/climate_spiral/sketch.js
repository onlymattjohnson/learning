let data;

function preload() {
  data = loadTable('data/giss-data-july-17-2023.csv', 'csv', 'header');
}

function setup() {
  createCanvas(600, 600);

  // Get first row
  let row = data.getRow(0);
}

function draw() {
  background(0);
  translate(width / 2, height / 2);
  
  stroke(255);
  strokeWeight(2);
  noFill();
  circle(0, 0, 100);
  fill(255);
  noStroke();
  text("0°", 54, 0);

  stroke(255);
  strokeWeight(2);
  noFill();
  circle(0, 0, 300);
  fill(255);
  noStroke();
  text("1°", 154, 0);
}
