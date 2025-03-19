# 🛠️ Welcome to Unity Game Development Tools for Linux

Welcome to this repository! Here, you’ll find a collection of tools crafted specifically to streamline game development in Unity and perform other essential tasks on Linux. These tools help automate and optimize workflows, saving you time and effort.

--------------------------

# 📋 List of Tools

### [1. 🔄 Auto Rename Images (Sprites)](./auto_rename_unity.sh)
- Easily rename multiple sprite image files and automatically update their corresponding .meta files to keep Unity references intact. This tool is particularly useful for maintaining organized and structured asset directories.
- 🚀 Usage:
  ``` bash
  ./auto_rename.sh /path/to/dir <type-image> <prefix>
  ```

### [2. 🖼️ Convert all image to .png](./convert_all_to_png.sh)
- Quickly convert all images within a specified directory from various formats (like .jpg, .webp, etc.) to .png. This script is perfect for standardizing image assets, making them ready for use in Unity.
- 🚀 Usage:
    ``` bash
    ./convert_all_to_png.sh /path/to/dir
    ```
    
### [3. 🔄 Convert all image to .png with name prefix](./convert_all_to_png.sh)
- Quickly convert all images within a specified directory from various formats (like .jpg, .webp, etc.) to .png and format the name with name prefix
- 🚀 Usage:
    ``` bash
    ./convert_all_with_prefix /path/to/dir 'prefix'
    ```
--------------------------

# 📂 Getting Started

### 1. Clone the repository
``` git bash
git clone <repository-url>
```

### 2. Make the Scripts Executable
```
chmod +x <script_file.sh>
```

### 3. Run the Scripts Using the Provided Commands:

--------------------------

# 🌟 Benefits of Using These Tools
- **Time-Saving**: Automate routine tasks and reduce manual work.
- **Ease of Use**: Simple commands make it accessible for any developer.

--------------------------

# 💡 Tips & Best Practices
- **Backup First**: Always back up your assets before running automated scripts.
- **Test in a Small Directory**: Run the scripts in a test directory to ensure they behave as expected.
- **Use Clear Prefixes**: When renaming images, choose meaningful prefixes for better organization.
