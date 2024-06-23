# Define paths
PROTO_DIR = proto
PROTO_FILES = $(PROTO_DIR)/rpc.proto
GEN_DIR = gen

# Define the Go modules
GO_OUT = $(GEN_DIR)
GO_GRPC_OUT = $(GEN_DIR)

# Define the protoc command
PROTOC = protoc
PROTOC_GEN_GO = protoc-gen-go
PROTOC_GEN_GO_GRPC = protoc-gen-go-grpc

# Ensure protoc-gen-go and protoc-gen-go-grpc are available
.PHONY: check-tools
check-tools:
	@command -v $(PROTOC) >/dev/null 2>&1 || { echo >&2 "protoc not installed. Aborting."; exit 1; }
	@command -v $(PROTOC_GEN_GO) >/dev/null 2>&1 || { echo >&2 "protoc-gen-go not installed. Aborting."; exit 1; }
	@command -v $(PROTOC_GEN_GO_GRPC) >/dev/null 2>&1 || { echo >&2 "protoc-gen-go-grpc not installed. Aborting."; exit 1; }

# Generate gRPC code
.PHONY: generate
generate: check-tools
	@mkdir -p $(GO_OUT)
	@mkdir -p $(GO_GRPC_OUT)
	$(PROTOC) -I=$(PROTO_DIR) --go_out=$(GO_OUT) --go-grpc_out=$(GO_GRPC_OUT) $(PROTO_FILES)

# Clean generated files
.PHONY: clean
clean:
	@rm -rf $(GEN_DIR)

# Default target
.PHONY: all
all: generate
