import { type RouteConfig, route } from "@react-router/dev/routes";

export default [
  route("", "routes/index.tsx"),
  route(
    "optimization/supervised-fine-tuning/:job_id?",
    "routes/optimization/supervised-fine-tuning/route.tsx",
  ),
  route(
    "api/curated_inferences/count",
    "routes/api/curated_inferences/count.route.ts",
  ),
  route(
    "api/datasets/count_inserts",
    "routes/api/datasets/count_inserts.route.ts",
  ),
  route(
    "api/datasets/count/dataset/:dataset_name/function/:function_name",
    "routes/api/datasets/count_dataset_function.route.ts",
  ),
  route(
    "api/dynamic_evaluations/search_runs",
    "routes/api/dynamic_evaluations/search_runs/route.ts",
  ),
  route(
    "api/evaluations/search_runs/:evaluation_name",
    "routes/api/evaluations/search_runs/$evaluation_name/route.ts",
  ),
  route(
    "api/function/:function_name/feedback_counts",
    "routes/api/function/$function_name/feedback_counts.route.ts",
  ),
  route("api/tensorzero/inference", "routes/api/tensorzero/inference.ts"),
  route("api/tensorzero/status", "routes/api/tensorzero/status.ts"),
  route("datasets", "routes/datasets/route.tsx"),
  route("datasets/builder", "routes/datasets/builder/route.tsx"),
  route("datasets/:dataset_name", "routes/datasets/$dataset_name/route.tsx"),
  route(
    "datasets/:dataset_name/datapoint/:id",
    "routes/datasets/$dataset_name/datapoint/$id/route.tsx",
  ),
  route("evaluations", "routes/evaluations/route.tsx"),
  route(
    "evaluations/:evaluation_name",
    "routes/evaluations/$evaluation_name/route.tsx",
  ),
  route(
    "evaluations/:evaluation_name/:datapoint_id",
    "routes/evaluations/$evaluation_name/$datapoint_id/route.tsx",
  ),
  route("dynamic_evaluations", "routes/dynamic_evaluations/route.tsx"),
  route(
    "dynamic_evaluations/runs/:run_id",
    "routes/dynamic_evaluations/runs/$run_id/route.tsx",
  ),
  route(
    "dynamic_evaluations/projects/:project_name",
    "routes/dynamic_evaluations/projects/$project_name/route.tsx",
  ),
  route(
    "observability/inferences",
    "routes/observability/inferences/route.tsx",
  ),
  route(
    "observability/episodes/:episode_id",
    "routes/observability/episodes/$episode_id/route.tsx",
  ),
  route(
    "observability/inferences/:inference_id",
    "routes/observability/inferences/$inference_id/route.tsx",
  ),
  route("observability/functions", "routes/observability/functions/route.tsx"),
  route(
    "observability/functions/:function_name",
    "routes/observability/functions/$function_name/route.tsx",
  ),
  route("observability/episodes", "routes/observability/episodes/route.tsx"),
  route(
    "observability/functions/:function_name/variants/:variant_name",
    "routes/observability/functions/$function_name/variants/route.tsx",
  ),
] satisfies RouteConfig;
