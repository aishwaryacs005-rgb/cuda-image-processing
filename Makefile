NVCC ?= nvcc
TARGET := image_processing
SOURCE := src/image_processing.cu
NVCC_FLAGS := -O2 -std=c++17

.PHONY: all clean dataset run
all: $(TARGET)

$(TARGET): $(SOURCE)
	$(NVCC) $(NVCC_FLAGS) $< -o $@

dataset:
	python3 scripts/generate_dataset.py --count 200 --width 256 --height 256

run: $(TARGET)
	./$(TARGET) --input-dir data/input --output-dir data/output

clean:
	rm -f $(TARGET)
	rm -f data/output/*.pgm
