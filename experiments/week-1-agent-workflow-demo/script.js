const steps = [
  {
    title: "Read the goal",
    body: "Agent 先讀懂學習者的目標、限制與輸出格式，避免一開始就亂做。",
    risk: "Risk: misunderstanding the task"
  },
  {
    title: "Plan the workflow",
    body: "把任務拆成幾個可檢查步驟，例如讀資料、整理筆記、產生草稿、檢查隱私。",
    risk: "Risk: skipping important checks"
  },
  {
    title: "Use tools",
    body: "Agent 可以讀檔、搜尋、產生頁面、執行測試，但每個工具結果都需要被檢查。",
    risk: "Risk: trusting tool output blindly"
  },
  {
    title: "Ask for confirmation",
    body: "遇到公開提交、push、授權、錢包簽名等高風險動作時，要讓人類確認。",
    risk: "Risk: taking public action too early"
  },
  {
    title: "Produce evidence",
    body: "最後輸出可追蹤的學習證明，例如 daily note、commit、demo link 或 submission draft。",
    risk: "Risk: no proof of learning"
  }
];

const stepButtons = document.querySelectorAll(".step-button");
const stepLabel = document.querySelector("#stepLabel");
const stepTitle = document.querySelector("#stepTitle");
const stepBody = document.querySelector("#stepBody");
const stepRisk = document.querySelector("#stepRisk");

function renderStep(index) {
  const step = steps[index];
  stepLabel.textContent = `Step ${index + 1}`;
  stepTitle.textContent = step.title;
  stepBody.textContent = step.body;
  stepRisk.textContent = step.risk;

  stepButtons.forEach((button) => {
    button.classList.toggle("active", Number(button.dataset.step) === index);
  });
}

stepButtons.forEach((button) => {
  button.addEventListener("click", () => renderStep(Number(button.dataset.step)));
});

const goalInput = document.querySelector("#goalInput");
const generatePlan = document.querySelector("#generatePlan");
const planOutput = document.querySelector("#planOutput");

generatePlan.addEventListener("click", () => {
  const goal = goalInput.value.trim() || "理解一個 AI x Web3 概念";
  planOutput.textContent = [
    `Goal: ${goal}`,
    "",
    "Agent workflow draft:",
    "1. Restate the goal in simple words.",
    "2. Split it into 3 small learning actions.",
    "3. Create a visible artifact: note, card, quiz, or demo.",
    "4. Run a privacy check before public sharing.",
    "5. Ask the learner to confirm commit / push / submission."
  ].join("\n");
});

const quizOptions = document.querySelectorAll(".quiz-option");
const quizResult = document.querySelector("#quizResult");

quizOptions.forEach((option) => {
  option.addEventListener("click", () => {
    quizOptions.forEach((item) => item.classList.remove("correct", "wrong"));
    const correct = option.dataset.correct === "true";
    option.classList.add(correct ? "correct" : "wrong");
    quizResult.textContent = correct
      ? "Correct. 安全的 agent 會先檢查，再做公開動作。"
      : "Try again. 高風險動作需要檢查與人工確認。";
  });
});

renderStep(0);

