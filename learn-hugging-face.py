from datasets import load_dataset
from huggingface_hub import hf_hub_download, snapshot_download

model_path = hf_hub_download(
    repo_id="sentence-transformers/all-MiniLM-L6-v2",
    filename="config.json"
)
print(f"Cached at: {model_path}")

model_dir = snapshot_download("sentence-transformers/all-MiniLM-L6-v2")
print(f"Full model at: {model_dir}")

# dataset = load_dataset("stanfordnlp/imdb", split="train")

# dataset.to_csv("imdb_train.csv")
# dataset.to_json("imdb_train.json")
# dataset.to_parquet("imdb_train.parquet")

# print(dataset)

# DATASET_ID = "wikimedia/wikipedia"
# CONFIG = "20231101.en"
# MAX_EXAMPLES = 50


# def main() -> None:
#     dataset = load_dataset(
#         DATASET_ID,
#         CONFIG,
#         split="train",
#         streaming=True,
#     )

#     for example in dataset.take(MAX_EXAMPLES):
#         print(example["title"])


# if __name__ == "__main__":
#     main()


# dataset = load_dataset("stanfordnlp/imdb", split="train")

# split = dataset.train_test_split(test_size=0.2, seed=42)
# train_val = split["train"].train_test_split(test_size=0.125, seed=42)

# train_ds = train_val["train"]
# val_ds = train_val["test"]
# test_ds = split["test"]

# print(f"Train: {len(train_ds)}, Val: {len(val_ds)}, Test: {len(test_ds)}")