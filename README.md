# Piplining 
Pipelining is the process of accumulating instruction from the processor through a pipeline. It allows storing and executing instructions in an orderly process. It is also known as pipeline processing.

Pipelining is a technique where multiple instructions are overlapped during execution. Pipeline is divided into stages and these stages are connected with one another to form a pipe like structure. Instructions enter from one end and exit fromanother end.

Pipelining increases the overall instruction throughput.In pipeline system, each segment consists of an input register followed by acombinational circuit. The register is used to hold data and combinational circuit
performs operations on it. The output of combinational circuit is applied to the input register of the next segment.

The pipeline will be more efficient if the instruction cycle is divided into segments of equal duration.
# Pipeline Conflicts

Some of these factors are given below:
## 1. Timing Variations
All stages cannot take same amount of time. This problem generally occurs in instruction processing where different instructions have different operand requirements and thus different processing time.
## 2. Data Hazards
When several instructions are in partial execution, and if they reference same data then the problem arises. We must ensure that next instruction does not attempt to access data before the current instruction, because this will lead to incorrect results.

## 3. Branching
In order to fetch and execute the next instruction, we must know what that instruction is. If the present instruction is a conditional branch, and its result will lead us to the next instruction, then the next instruction may not be known until the current one is processed.

## 4. Interrupts
Interrupts set unwanted instruction into the instruction stream. Interrupts effect the execution of instruction.

## 5. Data Dependency
It arises when an instruction depends upon the result of a previous instruction but this result is not yet available.
