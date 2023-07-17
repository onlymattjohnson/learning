// Define variables for data
let data;
let months;

function preload() {
  data = loadTable('data/giss-data-july-17-2023.csv', 'csv', 'header');
}

function setup() {
  createCanvas(600, 600);

  // Populate months variables
  // We remove the first column because it is Year
  months = data.columns.slice(1);

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

  stroke(255);
  strokeWeight(2);
  noFill();
  circle(0, 0, 500);

  // Add months to circle
  for (let i = 0; i < months.length; i++) {
    noStroke();
    fill(255);
    textAlign(CENTER);
    textSize(32);

    let angle = map(i, 0, months.length, 0, TWO_PI);
    let x = 250 * cos(angle);
    let y = 250 * sin(angle);
    
    text(months[i], x, y);
  }
}
