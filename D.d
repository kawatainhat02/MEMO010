import std.stdio; 

void main() 
{
    writeln("Hello, world!");
}




import std.stdio;

void main() {
    int multiplier = 10;
    int scaled(int x) { return x * multiplier; }

    foreach (i; 0 .. 10) {
        writefln("Hello, world %d! scaled = %d", i, scaled(i));
    }
}

int function(int) g;
g = (x) { return x * x; }; // longhand
g = (x) => x * x;          // shorthand


import std.stdio, std.algorithm, std.range;

void main()
{
    int[] a1 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    int[] a2 = [6, 7, 8, 9];

    // must be immutable to allow access from inside a pure function
    immutable pivot = 5;

    int mySum(int a, int b) pure nothrow // pure function
    {
        if (b <= pivot) // ref to enclosing-scope
            return a + b;
        else
            return a;
    }

    // passing a delegate (closure)
    auto result = reduce!mySum(chain(a1, a2));
    writeln("Result: ", result); // Result: 15

    // passing a delegate literal
    result = reduce!((a, b) => (b <= pivot) ? a + b : a)(chain(a1, a2));
    writeln("Result: ", result); // Result: 15
}

import std.stdio : writeln;
import std.range : iota;
import std.parallelism : parallel;

void main()
{
    foreach (i; iota(11).parallel) {
        // The body of the foreach loop is executed in parallel for each i
        writeln("processing ", i);
    }
}

import std.stdio : writeln;
import std.algorithm : map;
import std.range : iota;
import std.parallelism : taskPool;

/* On Intel i7-3930X and gdc 9.3.0:
 * 5140ms using std.algorithm.reduce
 * 888ms using std.parallelism.taskPool.reduce
 *
 * On AMD Threadripper 2950X, and gdc 9.3.0:
 * 2864ms using std.algorithm.reduce
 * 95ms using std.parallelism.taskPool.reduce
 */
void main()
{
  auto nums = iota(1.0, 1_000_000_000.0);

  auto x = taskPool.reduce!"a + b"(
      0.0, map!"1.0 / (a * a)"(nums)
  );

  writeln("Sum: ", x);
}

import std.stdio, std.concurrency, std.variant;

void foo()
{
    bool cont = true;

    while (cont)
    {
        receive( // Delegates are used to match the message type.
            (int msg) => writeln("int received: ", msg),
            (Tid sender) { cont = false; sender.send(-1); },
            (Variant v) => writeln("huh?") // Variant matches any type
        );
    }
}

void main()
{
    auto tid = spawn(&foo); // spawn a new thread running foo()

    foreach (i; 0 .. 10)
        tid.send(i);   // send some integers

    tid.send(1.0f);    // send a float
    tid.send("hello"); // send a string
    tid.send(thisTid); // send a struct (Tid)

    receive((int x) => writeln("Main thread received message: ", x));
}

ulong factorial(ulong n) {
    if (n < 2)
        return 1;
    else
        return n * factorial(n-1);
}

template Factorial(ulong n) {
    static if (n < 2)
        enum Factorial = 1;
    else
        enum Factorial = n * Factorial!(n-1);
}

enum fact_7 = Factorial!(7);

import std.string : format;
pragma(msg, format("7! = %s", fact_7));
pragma(msg, format("9! = %s", fact_9));


