CubeSat LoRa Communication System Setup Procedure
Hardware Requirements

Raspberry Pi 4 Model B (4GB RAM)
2x Waveshare SX126X LoRa HAT modules
MicroSD card (32GB recommended)
Jumper wires (female-to-female)
Breadboard (optional, for organized connections)
2x LoRa antennas
Power supply for Raspberry Pi

Step 1: Prepare Raspberry Pi
1.1 Install Raspberry Pi OS
1.2 Install Required Libraries

Step 2: Hardware Connections
2.1 Physical Wiring (Use the schematic above)
Module A1 (Ground Station) Connections:
SX126X HAT A1    →    Raspberry Pi 4
VCC              →    Pin 1  (3.3V)
GND              →    Pin 6  (GND)
RST              →    Pin 11 (GPIO 17)
DIO1             →    Pin 13 (GPIO 27)
BUSY             →    Pin 15 (GPIO 22)
CS               →    Pin 24 (GPIO 8)
MOSI             →    Pin 19 (GPIO 10)
MISO             →    Pin 21 (GPIO 9)
SCLK             →    Pin 23 (GPIO 11)

Module B2 (CubeSat) Connections:
SX126X HAT B2    →    Raspberry Pi 4
VCC              →    Pin 17 (3.3V)
GND              →    Pin 20 (GND)
RST              →    Pin 16 (GPIO 23)
DIO1             →    Pin 18 (GPIO 24)
BUSY             →    Pin 22 (GPIO 25)
CS               →    Pin 26 (GPIO 7)
MOSI             →    Pin 19 (GPIO 10) [Shared]
MISO             →    Pin 21 (GPIO 9)  [Shared]
SCLK             →    Pin 23 (GPIO 11) [Shared]

2.2 Antenna Installation

Connect antennas to both LoRa modules
Ensure antennas are properly seated in SMA connectors
Position antennas vertically for optimal radiation pattern

Step 3: Software Installation
3.1 Upload the Code
3.2 Create Additional Helper Scripts
3.3 Make Scripts Executable

Step 4: Initial Testing
4.1 Test GPIO Connections
4.2 Test SPI Communication
4.3 Basic Module Test

Step 5: Comprehensive Testing Protocol
5.1 Range Testing

Close Range Test (1-2 meters)
Test Commands:

Send "REQUEST_TELEMETRY" command
Verify telemetry response
Check RSSI values
Test beacon functionality


Medium Range Test (10-50 meters)

Repeat tests with increased distance
Monitor packet success rate
Record RSSI degradation
5.2 Performance Metrics to Monitor
Signal Quality:

RSSI (Received Signal Strength Indicator)
SNR (Signal-to-Noise Ratio)
Packet Error Rate (PER)

Timing:

Command response time
Beacon interval accuracy
Packet transmission time

System Health:

GPIO state monitoring
SPI communication errors
Module temperature (if available)

5.3 Automated Test Script
Step 6: Advanced Testing Scenarios
6.1 Orbital Pass Simulation
# Add to the test script
def simulate_orbital_pass():
    """Simulate satellite orbital pass"""
    print("Simulating orbital pass...")
    
    # Phase 1: Acquisition of Signal (AOS)
    print("AOS - Satellite rising...")
    test_weak_signal()
    
    # Phase 2: Maximum elevation
    print("Maximum elevation - Strong signal...")
    test_strong_signal()
    
    # Phase 3: Loss of Signal (LOS)  
    print("LOS - Satellite setting...")
    test_weak_signal()

Step 7: Troubleshooting
7.1 Common Issues
No Communication Between Modules:

Check all GPIO connections
Verify SPI is enabled
Test individual module initialization

Poor Signal Quality:

Check antenna connections
Verify frequency settings match
Test in open area away from interference

SPI Errors:
7.2 Debug Commands
# Check GPIO states
gpio readall

# Monitor SPI traffic (if available)
sudo apt install sigrok-cli
sigrok-cli -d fx2lafw -c samplerate=1MHz --continuous

# Check system logs
dmesg | grep spi
journalctl -f

Step 8: Data Logging and Analysis
8.1 Create Data Logger
# Add to the main script
import csv
from datetime import datetime

class DataLogger:
    def __init__(self, filename="lora_test_data.csv"):
        self.filename = filename
        self.init_csv()
    
    def init_csv(self):
        with open(self.filename, 'w', newline='') as f:
            writer = csv.writer(f)
            writer.writerow([
                'timestamp', 'direction', 'packet_type', 
                'rssi', 'snr', 'payload_size', 'success'
            ])
    
    def log_packet(self, direction, packet_type, rssi, snr, payload_size, success):
        with open(self.filename, 'a', newline='') as f:
            writer = csv.writer(f)
            writer.writerow([
                datetime.now().isoformat(),
                direction, packet_type, rssi, snr, payload_size, success
            ])
Check shared SPI bus connections (MOSI, MISO, SCLK)
Verify different CS pins for each module
Test SPI speed settings

8.2 Performance Analysis

Plot RSSI vs distance
Analyze packet success rates
Calculate link budget
Generate test reports

Step 9: Mission-Specific Customization
9.1 Adapt for Your CubeSat Mission

Modify telemetry parameters for your sensors
Adjust beacon intervals for mission requirements
Implement mission-specific commands
Add error handling for space environment

9.2 Integration with Ground Station Software

Interface with existing ground station software
Implement standard protocols (CCSDS, etc.)
Add database logging for operations

Expected Test Results
Successful Test Indicators:

Both modules initialize without errors
Commands sent from Ground Station are received by CubeSat
Telemetry data is transmitted and received correctly
RSSI values are reasonable (-40 to -100 dBm depending on distance)
Packet success rate > 95% at close range
Beacon timing is accurate

Performance Benchmarks:

Command response time: < 1 second
Maximum range: 1-5 km (depending on environment and antennas)
Data rate: ~1-10 kbps depending on SF settings
Current consumption: ~100mA during TX, ~15mA during RX
