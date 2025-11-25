pred_path=$1 # the path to the predicted data
gt_path=$2 # the path to the ground truth data
eval_dir=$3
resulting_path=${4:-"eval_results.jsonl"} # the path to the resulting data
prompt_ver=${5:-"none"} # the version of the prompt

GPT_MODEL_NAME="gpt-3.5-turbo-0301"
export OPENAI_KEY=""
export OPENAI_BACKEND=""

file_name=$(basename $pred_path)
if [[ $file_name == *"jsonl"* ]]; then
    fn=${file_name%.jsonl}
else
    fn=${file_name%.json}
fi

output_dir=$eval_dir/${fn}
output_path=${output_dir}.jsonl
mkdir -p $output_dir

echo pred_path: $pred_path
echo ground truth qa and caption: $gt_path
echo output_dir: $output_dir


num_tasks=10
export PYTHONPATH=.

echo $GPT_MODEL_NAME

python3 test/eval/eval_qa.py \
    --gt_path ${gt_path} --pred_path ${pred_path} \
    --output_dir ${output_dir} --output_path ${output_path} \
    --model_name $GPT_MODEL_NAME \
    --num_tasks ${num_tasks} \
    --resulting_path ${resulting_path} \
    --prompt_ver $prompt_ver \
    # --num_samples ${num_samples}
    # --temperature ${temperature}
    # --top_p ${top_p}
    # --max_new_tokens ${max_new_tokens}
