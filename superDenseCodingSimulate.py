import qsharp
from Qexp import SimulateSuperdebseCoding
import argparse

# construct the argument parser
ap = argparse.ArgumentParser()
ap.add_argument("-f", "--bit1", type=bool, default=False, help="First Bit to transfer using super Dense coding")
ap.add_argument("-s", "--bit2", type=bool, default=False, help="Second Bit to transfer using super Dense coding")
args = vars(ap.parse_args())

print(SimulateSuperdebseCoding.simulate(bit1 = args["bit1"], bit2 = args["bit2"]))




