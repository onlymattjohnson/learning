// Define variables for data
let data;
let months;

function preload() {
  data = loadTable('data/giss-data-july-17-2023.csv', 'csv', 'header');
}

function setup() {
  createCanvas(600, 600);

  // Populate months variables
  // months = data.columns.slice(1, 13);
  months = ["Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec", "Jan", "Feb"];

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
  text("0°", 70, 0);

  stroke(255);
  strokeWeight(2);
  noFill();
  circle(0, 0, 300);
  fill(255);
  noStroke();
  text("1°", 170, 0);

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
    push();
    let x = 264 * cos(angle);
    let y = 264 * sin(angle);
    translate(x,y);
    rotate(angle + PI/2);
    text(months[i], 0, 0);
    pop();
  }

  // Get first row
  let row = data.getRow(0);
  let year = row.get("Year");
  
  textAlign(CENTER, CENTER);
  text(year, 0, 0);

  for (let i = 0; i < months.length; i++) {
    let anomaly = row.getNum(months[i]);
  }
}
