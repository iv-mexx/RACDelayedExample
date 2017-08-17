Sample Project for https://stackoverflow.com/questions/45712086/how-to-satisfy-this-situation-by-using-reactivecocoa/

### Setup

* Clone this project
* `cd` into the project folder
* Run `git submodule update --init --recursive` to checkout dependencies
* Open the Project
* Build & Run

### Problem Description

This project implements a solution to the question asked in [this stackoverflow post](https://stackoverflow.com/questions/45712086/how-to-satisfy-this-situation-by-using-reactivecocoa/).

Events on one the `source` signal are split into two different streams. One stream, `CS1` applies some transformation via map and sends the events immediately.
The other stream, `CS2` also applies a transformation, but sends the events with a delay. However, if a new event arrives on `CS1`, the delayed event on `CS2` should be cancelled!.

`CS1` and `CS2` are then merged into one resulting signal, `CS3`.

### Solution

[See the Answer on StackOverflow](https://stackoverflow.com/a/45720927/1066219)

### Usage

Run the project and you will see a button. Open up the debug console where events will be logged. Each click on the button will send a new value on `source` with increasing integer values. All integer values will be sent immediately on `CS1`. Even integer values will also be be sent on `CS2` where they are delayed by 3 seconds. If the button is clicked again before the delayed value arrives, the delayed value will be cancelled.