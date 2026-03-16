# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def alu_test_fulladder(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("ALU behavior 4 bit full adder")

    # Not every combination is tested: Most important are the overflow cases and the functions of the other flags. Sum looks anyway good according to simulation with ghdl on the original vhdl module
    dut.ui_in.value = int('00010110', 2) # port A = 6, port B = 1
    dut.uio_in.value = 0

    # Wait for three clock cycle to see the output values, nobody knows, why 3 and not two clock cycles...seems to be a cocotb error I guess, because vhdl simulation works finde
    await ClockCycles(dut.clk, 3)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == int('00000111', 2)

    # Keep testing the module by changing the input values, waiting for
    # one or more clock cycles, and asserting the expected output values.

    dut.ui_in.value = int('00010111', 2) # port A = 7, port B = 1

    # Wait for three clock cycle to see the output values
    await ClockCycles(dut.clk, 3)

    assert dut.uo_out.value == int('11001000', 2) # V-Flag = 1, N-Flag = 1, output = -8

    dut.ui_in.value = int('01110001', 2) # port A = 1, port B = 7

    # Wait for three clock cycle to see the output values
    await ClockCycles(dut.clk, 3)

    assert dut.uo_out.value == int('11001000', 2) # V-Flag = 1, N-Flag = 1, output = -8

    dut.ui_in.value = int('00011000', 2) # port A = -8, port B = 1
    dut.uio_in.value = 1 # subtract mode

    # Wait for three clock cycle to see the output values
    await ClockCycles(dut.clk, 3)

    assert dut.uo_out.value == int('10010111', 2) # V-Flag = 1, C-Flag = 1, output = 7

    dut.ui_in.value = int('10000001', 2) # port A = 1, port B = -8
    dut.uio_in.value = 1 # subtract mode

    # Wait for three clock cycle to see the output values
    await ClockCycles(dut.clk, 3)

    assert dut.uo_out.value == int('11001001', 2) # V-Flag = 1, N-Flag = -7, output = 7


    dut.ui_in.value = int('00010001', 2) # port A = 1, port B = 1
    dut.uio_in.value = 1 # subtract mode

    # Wait for three clock cycle to see the output values
    await ClockCycles(dut.clk, 3)

    assert dut.uo_out.value == int('00110000', 2) # Z-Flag = 1, Carry = 1

    dut.ui_in.value = int('00010000', 2) # port A = 0, port B = 1
    dut.uio_in.value = 1 # subtract mode

    # Wait for three clock cycle to see the output values
    await ClockCycles(dut.clk, 3)

    assert dut.uo_out.value == int('01001111', 2) # N-Flag = 1, output = -1


@cocotb.test()
async def alu_test_logic_operations(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("ALU behavior logic operations")

    # Set the input values you want to test
    dut.ui_in.value = int('10111010', 2)
    dut.uio_in.value = int('00000010', 2) # and output

    # Wait for three clock cycle to see the output values, nobody knows, why 3 and not two clock cycles...seems to be a cocotb error I guess, because vhdl simulation works finde
    await ClockCycles(dut.clk, 3)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == int('10001010', 2) # Flags are irrelevant with logic operations, don't know how to set them to "don't care"

    dut.uio_in.value = int('00000100', 2) # or output

    await ClockCycles(dut.clk, 2)

    assert dut.uo_out.value == int('10001011', 2) # Flags are irrelevant with logic operations, don't know how to set them to "don't care"

    dut.uio_in.value = int('00000110', 2) # xor output

    await ClockCycles(dut.clk, 2)

    assert dut.uo_out.value == int('10000001', 2) # Flags are irrelevant with logic operations, don't know how to set them to "don't care"
    
    dut.uio_in.value = int('00001000', 2) # ones complement output

    await ClockCycles(dut.clk, 2)

    assert dut.uo_out.value == int('10000101', 2) # Flags are irrelevant with logic operations, don't know how to set them to "don't care"
    

@cocotb.test()
async def alu_test_shift_operations(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("ALU behavior shift operations")

    dut.ui_in.value = int('00001010', 2)
    dut.uio_in.value = int('00001010', 2) # shift left arithmetic output

    # Wait for three clock cycle to see the output values, nobody knows, why 3 and not two clock cycles...seems to be a cocotb error I guess, because vhdl simulation works finde
    await ClockCycles(dut.clk, 3)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == int('01001100', 2) # Flags are irrelevant with logic operations, don't know how to set them to "don't care"

    dut.uio_in.value = int('00001100', 2) # shift left logic output

    # Wait for three clock cycle to see the output values, nobody knows, why 3 and not two clock cycles...seems to be a cocotb error I guess, because vhdl simulation works finde
    await ClockCycles(dut.clk, 2)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == int('01000100', 2) # Flags are irrelevant with logic operations, don't know how to set them to "don't care"

    dut.uio_in.value = int('00001110', 2) # shift right arithmetic output

    # Wait for three clock cycle to see the output values, nobody knows, why 3 and not two clock cycles...seems to be a cocotb error I guess, because vhdl simulation works finde
    await ClockCycles(dut.clk, 2)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == int('01001101', 2) # Flags are irrelevant with logic operations, don't know how to set them to "don't care"

    dut.uio_in.value = int('00010000', 2) # shift right logic output

    # Wait for three clock cycle to see the output values, nobody knows, why 3 and not two clock cycles...seems to be a cocotb error I guess, because vhdl simulation works finde
    await ClockCycles(dut.clk, 2)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == int('01000101', 2) # Flags are irrelevant with logic operations, don't know how to set them to "don't care"

@cocotb.test()
async def alu_test_rotate_operations(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("ALU behavior rotate operations")

    dut.ui_in.value = int('00001010', 2)
    dut.uio_in.value = int('00010010', 2) # rotate left  output

    # Wait for three clock cycle to see the output values, nobody knows, why 3 and not two clock cycles...seems to be a cocotb error I guess, because vhdl simulation works finde
    await ClockCycles(dut.clk, 3)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == int('01000101', 2) # Flags are irrelevant with logic operations, don't know how to set them to "don't care"

    dut.uio_in.value = int('00010100', 2) # rotate right output

    # Wait for three clock cycle to see the output values, nobody knows, why 3 and not two clock cycles...seems to be a cocotb error I guess, because vhdl simulation works finde
    await ClockCycles(dut.clk, 2)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == int('01000101', 2) # Flags are irrelevant with logic operations, don't know how to set them to "don't care"

    dut.uio_in.value = int('00010110', 2) # rotate left through carry output

    # Wait for three clock cycle to see the output values, nobody knows, why 3 and not two clock cycles...seems to be a cocotb error I guess, because vhdl simulation works finde
    await ClockCycles(dut.clk, 2)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == int('01010100', 2) #

    dut.uio_in.value = int('00011000', 2) # rotate right through carry output

    # Wait for three clock cycle to see the output values, nobody knows, why 3 and not two clock cycles...seems to be a cocotb error I guess, because vhdl simulation works finde
    await ClockCycles(dut.clk, 2)

    # The following assersion is just an example of how to check the output values.
    # Change it to match the actual expected output of your module:
    assert dut.uo_out.value == int('01001101', 2) #