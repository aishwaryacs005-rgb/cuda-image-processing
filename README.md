# GPU-Accelerated Image Processing Using CUDA

## Project overview
This project processes a batch of RGB images with an NVIDIA GPU. A custom CUDA kernel performs two operations: RGB-to-grayscale conversion and Sobel edge detection. Each input image produces two output images (`*_gray.pgm` and `*_edges.pgm`).

## Requirements
- NVIDIA GPU with a compatible CUDA driver
- CUDA Toolkit (`nvcc`)
- C++17-capable host compiler
- Python 3 (only for generating the sample dataset)
- Linux lab environment recommended

## Dataset
The supplied generator creates 200 reproducible 256 x 256 RGB PPM images. The images are synthetic, so no external dataset download is required.

```bash
python3 scripts/generate_dataset.py --count 200 --width 256 --height 256
```

## Build
```bash
make clean
make
```

## Run
```bash
./image_processing --input-dir data/input --output-dir data/output
```

Optional arguments:
- `--input-dir DIR`: directory containing binary PPM (`.ppm`) images
- `--output-dir DIR`: directory for generated PGM files
- `--count N`: process at most N input images
- `--help`: display command-line help

Example:
```bash
./image_processing --input-dir data/input --output-dir data/output --count 50
```

## CUDA implementation
The program checks for CUDA devices, selects device 0, allocates device memory, copies RGB pixels to the GPU, launches a 16 x 16 thread-block grid, synchronizes, and copies grayscale and edge results back to the host. The kernel uses the standard luminance weights (0.299, 0.587, 0.114) and a 3 x 3 Sobel operator. Boundary coordinates are clamped to the image edges.

The reported per-image pipeline time includes host-to-device transfer, kernel execution/synchronization, and device-to-host transfers. It excludes image file reading and writing.

## Output
For each `image_NNNN.ppm`, the program writes:
- `image_NNNN_gray.pgm`: grayscale image
- `image_NNNN_edges.pgm`: Sobel edge magnitude image

PGM files can be viewed with common image viewers or converted with ImageMagick.

## Evidence for the Coursera submission
Run the program in the CUDA lab and capture the terminal output showing the detected GPU, processed image count, and timing. Save that genuine run log as `artifacts/execution_log.txt`. Also save a screenshot of the terminal and a few input/output image examples in `artifacts/`. Do not use fabricated logs: the evidence must come from an actual CUDA execution.

## Suggested repository structure
```text
cuda_image_processing_project/
├── src/image_processing.cu
├── scripts/generate_dataset.py
├── data/input/                 # generated PPM dataset
├── data/output/                # generated PGM results
├── artifacts/                  # genuine execution evidence
├── Makefile
└── README.md
```

## GitHub upload
Create a public GitHub repository, for example `cuda-image-processing`, then run:
```bash
git init
git add .
git commit -m "Add CUDA batch image processing project"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/cuda-image-processing.git
git push -u origin main
```
Replace `YOUR_USERNAME` with your GitHub username. The repository URL above is a template; it is not an existing repository.

## Notes
This is a learning project scaffold. Review the code, run it yourself in the course environment, and make sure you understand and can explain the CUDA kernel and results. Follow your course's rules on AI assistance and disclose assistance if required.
