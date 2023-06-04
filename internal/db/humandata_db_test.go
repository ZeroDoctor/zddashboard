package db

import (
	"fmt"
	"testing"
)

func TestBatchNamedExec(t *testing.T) {

	var batch []int
	batchSize := 7
	for i := 0; i < batchSize; i++ {
		batch = append(batch, i)
	}

	size := 20
	if len(batch) < size {
		size = len(batch)
	}

	fmt.Println("target:", batch)
	for current := 0; current < len(batch); current += size {
		if current+size > len(batch) {
			size -= ((current + size) - len(batch))
		}

		fmt.Printf("[batch=%d] [current=%d] [size=%d] [window=%d]\n", batch[current:current+size], current, size, current+size)
	}

	batchSize = 30
	for i := 0; i < batchSize; i++ {
		batch = append(batch, i)
	}

	size = 20
	if len(batch) < size {
		size = len(batch)
	}

	fmt.Println("target:", batch)
	for current := 0; current < len(batch); current += size {
		if current+size > len(batch) {
			size -= ((current + size) - len(batch))
		}

		fmt.Printf("[batch=%d] [current=%d] [size=%d] [window=%d]\n", batch[current:current+size], current, size, current+size)
	}
}
