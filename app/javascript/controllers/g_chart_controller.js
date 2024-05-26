import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="g-chart"
export default class extends Controller {
  static targets = ["chart", "table"];

  connect() {
    google.charts.load("current", { packages: ["corechart", "table"] });
    google.charts.setOnLoadCallback(this.drawSort.bind(this));
  }

  drawSort() {
    const dataArr = this.getData();
    if (dataArr.length === 0) {
      return;
    }
    // Create the data table from the array.
    var data = google.visualization.arrayToDataTable([
      ["Month", "Earnings", "Expenses", "Balance"], // Add column headers
      ...dataArr, // Spread the array of data
    ]);
    var options = {
      title: "Your finances by the year",
      vAxis: { title: "R$ BRL" },
      hAxis: { title: "Month" },
      seriesType: "bars",
      series: { 2: { type: "area" } },
      colors: ["#1982c4", "#bc4b51", "green"],
    };

    var view = new google.visualization.DataView(data);
    view.setColumns([0, 1]);

    var table = new google.visualization.Table(
      document.getElementById("table")
    );
    table.draw(data, { width: "100%", height: "100%" });

    var chart = new google.visualization.ComboChart(
      document.getElementById("combo-chart")
    );
    chart.draw(data, options);
  }

  getData() {
    const dataFromReportController = JSON.parse(this.chartTarget.dataset.info);
    const [earnigsByMonth, expensesByMonth] = dataFromReportController;
    const earningsObj = JSON.parse(earnigsByMonth);
    const expensesObj = JSON.parse(expensesByMonth);
    let result = [];
    // loop over the keys of earningsObj and check if expensesObj has the same key
    for (let key in expensesObj) {
      let earnings = earningsObj[key] || 0;
      let expenses = expensesObj[key] || 0;

      if (earnings.hasOwnProperty(key)) {
        // create an array with the key and the values
        let array = [key, earnings, expenses, earnings - expenses];
        result.push(array);
      } else {
        result.push([key, earnings, expenses, earnings - expenses]);
      }
    }
    return result;
  }
}
