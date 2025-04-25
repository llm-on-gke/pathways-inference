# Copyright 2025 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

apiVersion: batch/v1
kind: Job
metadata:
  name: checkpoint-converter
spec:
  template:
    spec:
      restartPolicy: Never
      containers:
      - name: inference-checkpoint
        image: us-docker.pkg.dev/cloud-tpu-images/inference/inference-checkpoint:v0.2.5
        imagePullPolicy: Always
        args:
        - --bucket_name=rick-llama405b-checkpoint
        - --inference_server=jetstream-maxtext
        - --meta_url=https://llama3-1.llamameta.net/*?Policy=eyJTdGF0ZW1lbnQiOlt7InVuaXF1ZV9oYXNoIjoiaGNsZmpsdnFhZnV1eXJ0N2FzdWk2ZmVoIiwiUmVzb3VyY2UiOiJodHRwczpcL1wvbGxhbWEzLTEubGxhbWFtZXRhLm5ldFwvKiIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MTc0NTY4MTkwMn19fV19&Signature=rAX0HPgJwZHHYo%7EER2ID0rMNwFLJBSYwFjWLXyaeYVi8VBsUoQ-llXLf85w2OLqZHHUP48OfYN%7E9n8y1FRMOvZ2HVVtzsL5qjBEnXl71qdfgkGpwcxbZyHozNgUnV4GOqWPkUWXLYl3hALcAAv1JtBy0t5ScGwwWLOZENcbtSz-DfX-yG6xJ9oXbs%7EEI9eNtvKnfId7-LbsTWwmhSXWS7Apf0BrtHPEQyydKdlN%7E2MKvRZgfROFCcQSAn82VgJTC9CRuzHFTr989l4ejMbvhXb%7Ev3HG0mUe6O6LQBZJXDjaJE9d-SOc1q8HRb8B1WrCOtHeyH5XIl2TNISQyoHlHhg__&Key-Pair-Id=K15QRJLYKIFSLZ&Download-Request-ID=1025948705787836
        - --model_name=llama-3.1
        - --model_path=Llama3.1-405B-Instruct:bf16-mp16
        - --output_directory=gs://rick-llama405b-checkpoint/maxtext/llama-3.1-405b
        - --quantize_type=int8
        - --quantize_weights=True
      nodeSelector:
        cloud.google.com/gke-nodepool: cpu-pathways-np
