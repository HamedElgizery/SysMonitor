const express = require('express');
const app = express();
const path = require('path');
const fs = require('fs');

const base_path = "/logs"

app.get("/", (req, res) => {
    res.sendFile(__dirname + '/main.html');
})

app.get('/cpu-page', (req, res) => {
    res.sendFile(__dirname + '/cpu_page.html');
});

app.get('/gpu-page', (req, res) => {
    res.sendFile(__dirname + '/gpu_page.html');
});

app.get('/disk-page', (req, res) => {
    res.sendFile(__dirname + '/disk_page.html');
});

app.get('/mem-page', (req, res) => {
    res.sendFile(__dirname + '/mem_page.html');
});

app.get('/net-page', (req, res) => {
    res.sendFile(__dirname + '/net_page.html');
});

app.get('/sys-page', (req, res) => {
    res.sendFile(__dirname + '/sys_load_page.html');
});


app.get('/getcpu', (req, res) => {
    const cpuLogPath = path.resolve(`/${base_path}/cpu_logs.txt`);
    const cpuTempLogPath = path.resolve(`/${base_path}/cpu_temp_logs.txt`);

    try {
        const cpuLog = fs.readFileSync(cpuLogPath, 'utf-8');
        const cpuLogLines = cpuLog.trim().split('\n');
        const lastCpuLine = cpuLogLines[cpuLogLines.length - 1];
        const cpuData = JSON.parse('[' + lastCpuLine.split(',').slice(1).join(',') + ']');

        const cpuTempLog = fs.readFileSync(cpuTempLogPath, 'utf-8');
        const cpuTempLogLines = cpuTempLog.trim().split('\n');
        const lastCpuTempLine = cpuTempLogLines[cpuTempLogLines.length - 1];

        const cleanedCpuTempLine = lastCpuTempLine.replace(/\+/g, '');
        const cpuTempData = JSON.parse('[' + cleanedCpuTempLine.split(',').slice(1).join(',') + ']');

        res.json({ metrics: cpuData, cores: cpuTempData });
    } catch (error) {
        console.error('Error reading logs:', error);
        res.status(500).json({ error: 'Failed to read CPU logs' });
    }
});

app.get('/getgpu', (req, res) => {
    const gpuLogPath = path.resolve(`/${base_path}/gpu_logs.txt`);

    try {
        const gpuLog = fs.readFileSync(gpuLogPath, 'utf-8');
        const gpuLogLines = gpuLog.trim().split('\n');
        const lastGpuLine = gpuLogLines[gpuLogLines.length - 1];

        const processedLine = lastGpuLine
            .split(',')
            .slice(2)
            .map(value => `"${value.trim()}"`)
            .join(',');

        const gpuData = JSON.parse(`[${processedLine}]`);

        res.json({ metrics: gpuData });
    } catch (error) {
        console.error('Error reading logs:', error);
        res.status(500).json({ error: 'Failed to read GPU logs' });
    }
});

app.get('/getdisk', (req, res) => {
    const diskLogPath = path.resolve(`/${base_path}/disk_logs.txt`);

    try {
        const diskLog = fs.readFileSync(diskLogPath, 'utf-8');
        const diskLogLines = diskLog.trim().split('\n');
        const lastDiskLine = diskLogLines[diskLogLines.length - 1];

        const diskData = lastDiskLine.split(',').slice(1).map(value => `"${value.trim()}"`).join(',');

        res.json({ metrics: JSON.parse(`[${diskData}]`) });
    } catch (error) {
        console.error('Error reading logs:', error);
        res.status(500).json({ error: 'Failed to read Disk logs' });
    }
});

app.get('/getmem', (req, res) => {
    const memLogPath = path.resolve(`/${base_path}/mem_logs.txt`);

    try {
        const memLog = fs.readFileSync(memLogPath, 'utf-8');
        const memLogLines = memLog.trim().split('\n');
        const lastMemLine = memLogLines[memLogLines.length - 1];

        const memData = lastMemLine.split(',').slice(1).map(value => `"${value.trim()}"`).join(',');

        res.json({ metrics: JSON.parse(`[${memData}]`) });
    } catch (error) {
        console.error('Error reading logs:', error);
        res.status(500).json({ error: 'Failed to read Memory logs' });
    }
});


app.get('/getnetwork', (req, res) => {
    const networkLogPath = path.resolve(`/${base_path}/net_logs.txt`);

    try {
        const networkLog = fs.readFileSync(networkLogPath, 'utf-8');
        const networkLogLines = networkLog.trim().split('\n');

        const interfaces = {};
        networkLogLines.forEach(line => {
            const parts = line.split(',');
            const timestamp = parts[0].trim();
            const interfaceName = parts[1].trim(); 

            const metrics = parts.slice(2).map(value => value.trim());

            if (!interfaces[interfaceName]) {
                interfaces[interfaceName] = { timestamp, metrics };
            }
        });

        const result = Object.keys(interfaces).map(interfaceName => ({
            Interface: interfaceName,
            Timestamp: interfaces[interfaceName].timestamp,
            Metrics: interfaces[interfaceName].metrics,
        }));

        res.json({ interfaces: result });
    } catch (error) {
        console.error('Error reading logs:', error);
        res.status(500).json({ error: 'Failed to read Network logs' });
    }
});

app.get('/getsysload', (req, res) => {
    
    const sysLoadLogPath = path.resolve(`/${base_path}/load_logs.txt`);

    try {
        const sysLoadLog = fs.readFileSync(sysLoadLogPath, 'utf-8');
        const sysLoadLogLines = sysLoadLog.trim().split('\n');
        const lastSysLoadLine = sysLoadLogLines[sysLoadLogLines.length - 1];
        const sysLoadData = lastSysLoadLine.split(',').slice(1, 4).map(parseFloat);

        res.json({ metrics: sysLoadData });
    } catch (error) {
        console.error('Error reading logs:', error);
        res.status(500).json({ error: 'Failed to read System Load logs' });
    }
});



app.listen(3000, () => {
    console.log('Example app listening on port 3000!');
});
