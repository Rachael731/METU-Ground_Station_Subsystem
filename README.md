# Complete Plugin Directory Structure
openc3-cosmos-lora-METUCUBE/
├── .gitignore
├── Rakefile
├── requirements.txt
├── plugin.txt
├── README.md
├── lib/
│   └── lora_system_interface.rb
├── config/
│   └── targets/
│       └── LORA_SYSTEM/
│           ├── target.txt
│           ├── cmd_tlm/
│           │   ├── lora_system_cmd.txt
│           │   └── lora_system_tlm.txt
│           └── procedures/
│               ├── test_lora_basic.rb
│               ├── test_lora_range.rb
│               ├── test_lora_stress.rb
│               └── test_lora_config.rb
└── microservices/
    └── LORA_SYSTEM/
        └── lora_bridge.py