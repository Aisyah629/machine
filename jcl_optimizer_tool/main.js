const fs = require('fs');
const path = require('path');

class JCLOptimizer {
    constructor(configPath) {
        this.config = JSON.parse(fs.readFileSync(configPath, 'utf8'));
        this.jobs = [];
    }

    parseJCL(jclContent) {
        const lines = jclContent.split('\n');
        const job = { name: '', steps: [] };
        let currentStep = null;

        for (const line of lines) {
            if (line.trim().startsWith('//*') || line.trim() === '') continue;

            if (line.trim().startsWith('JOB')) {
                job.name = line.split(',')[0].replace('JOB', '').trim();
            } else if (line.trim().startsWith('EXEC')) {
                currentStep = { name: line.split(',')[0].replace('EXEC', '').trim(), procs: [] };
                job.steps.push(currentStep);
            } else if (currentStep) {
                currentStep.procs.push(line.trim());
            }
        }
        return job;
    }

    optimize(job) {
        job.steps = job.steps.map(step => {
            let priority = 5;
            let timeLimit = this.config.cpu_limit;

            if (step.name.includes('HIGH')) {
                priority = 1;
                timeLimit = 500;
            }

            if (step.name.includes('LOW')) {
                priority = 10;
            }

            return {
                ...step,
                optimized: true,
                priority,
                timeLimit
            };
        });

        job.steps.sort((a, b) => a.priority - b.priority);
        return job;
    }

    run(jclContent) {
        const parsedJob = this.parseJCL(jclContent);
        const optimizedJob = this.optimize(parsedJob);
        return JSON.stringify(optimizedJob, null, 2);
    }
}

const optimizer = new JCLOptimizer('./jcl_optimizer_tool.conf');
const jclContent = fs.readFileSync(path.join(__dirname, 'input.jcl'), 'utf8');
console.log(optimizer.run(jclContent));
