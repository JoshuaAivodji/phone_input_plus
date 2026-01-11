## 0.2.0

**Major Update** 🚀

### Added

-  **52 African Countries** - Complete coverage of all African nations
    - West Africa: Benin, Burkina Faso, Cape Verde, Gambia, Ghana, Guinea, Guinea-Bissau, Ivory Coast, Liberia, Mali, Mauritania, Niger, Nigeria, Senegal, Sierra Leone, Togo
    - Central Africa: Cameroon, Central African Republic, Chad, Republic of the Congo, DR Congo, Equatorial Guinea, Gabon, São Tomé and Príncipe
    - East Africa: Burundi, Djibouti, Eritrea, Ethiopia, Kenya, Rwanda, Somalia, South Sudan, Tanzania, Uganda, Seychelles, Comoros
    - Southern Africa: Angola, Botswana, Lesotho, Malawi, Mozambique, Namibia, South Africa, Eswatini, Zambia, Zimbabwe
    - North Africa: Algeria, Egypt, Libya, Morocco, Sudan, Tunisia

-  **Intelligent Paste Detection** - Automatically detects country from pasted international numbers
    - Paste `+2290166640219` → Auto-detects Benin and formats correctly
    - Works with any international format
    - Configurable via `enablePasteDetection` parameter

-  **Dynamic Length Limitation** - Automatically limits input length based on selected country
    - Prevents typing more digits than allowed
    - Updates dynamically when country changes
    - No manual configuration needed

-  **Adaptive Keyboard Type** - Intelligently chooses keyboard based on features
    - Text keyboard when paste detection enabled (allows `+`)
    - Numeric keyboard when paste detection disabled
    - Manual override available via `keyboardType` parameter

- ️ **JSON to Dart Generation Script** - Tool to easily add more countries from JSON data

### Improved

-  Better code organization with regional country files
-  Enhanced documentation with more examples
-  More accurate validation patterns for African countries
-  Better handling of country-specific formatting rules (e.g., French phone numbers)

### Fixed

-  French phone number handling (removes leading 0 correctly)
-  Country detection by dial code (sorts by length to avoid conflicts)
-  Pattern validation escaping in generated code


## 0.1.0

**Major Update**

### Added
-  Additional African countries support
-  More European countries
-  More American countries
-  English screenshots for better international reach
-  Pub.dev badges in README

### Improved
-  Better internationalization
-  Wider country coverage

## 0.0.1

**Initial Release**

### Features

-  Phone input field with auto country detection
-  Support for 54 African countries + France & USA
-  Real-time number formatting as you type
-  Country-specific validation with regex patterns
-  Searchable country selector with multiple display modes (BottomSheet, Dialog, Page)
-  PhoneController for programmatic control
-  Smart caching of detected country (24h default)
-  IP-based detection with device locale fallback
-  Highly customizable styling options
-  Special handling for French phone numbers (removes leading 0)
-  Multi-language support (English & French)

### Supported Countries

**Africa (5 countries):**
- 🇧🇯 Benin
- 🇬🇦 Gabon
- 🇸🇳 Senegal
- 🇨🇮 Côte d'Ivoire
- 🇨🇲 Cameroon

**Other:**
- 🇫🇷 France
- 🇺🇸 United States
- 🇨🇦 Canada

*Note: More African countries will be added in future releases.*

### Documentation

- Complete README with usage examples
- Working example app demonstrating all features
- Full API documentation in code comments
