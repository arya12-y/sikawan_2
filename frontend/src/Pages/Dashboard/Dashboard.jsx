import { useCallback, useEffect, useState } from 'react'
import { Bar, Doughnut, Radar } from 'react-chartjs-2'
import { Chart as ChartJS, ArcElement, BarElement, CategoryScale, LinearScale, PointElement, LineElement, RadialLinearScale, Filler, Tooltip, Legend } from 'chart.js'
import api from '../../api/axios'

ChartJS.register(ArcElement, BarElement, CategoryScale, LinearScale, PointElement, LineElement, RadialLinearScale, Filler, Tooltip, Legend)

const theme = {
  indigo: '#6366f1',
  cyan: '#06b6d4',
  emerald: '#10b981',
  amber: '#f59e0b',
  rose: '#f43f5e',
  purple: '#a855f7',
  pink: '#ec4899',
  teal: '#14b8a6',
}

const palette = Object.values(theme)

const makeChart = (items = [], label) => ({
  labels: items.map((item) => item.label),
  datasets: [{
    label,
    data: items.map((item) => item.value),
    backgroundColor: palette,
    borderRadius: 6,
    borderSkipped: false,
  }],
})

const makeRadar = (items = []) => ({
  labels: items.map((item) => item.label),
  datasets: [{
    label: 'Nilai Kompetensi',
    data: items.map((item) => item.value),
    backgroundColor: 'rgba(99,102,241,0.12)',
    borderColor: theme.indigo,
    borderWidth: 2,
    pointBackgroundColor: theme.indigo,
    pointBorderColor: '#fff',
    pointRadius: 4,
  }],
})

function Empty({ text, sub }) {
  return (
    <div className="d-flex flex-column align-items-center justify-content-center text-muted" style={{ minHeight: 200 }}>
      <i className="bi bi-bar-chart-line mb-2" style={{ fontSize: '2.5rem', opacity: 0.25 }}></i>
      <span className="small fw-medium">Belum ada data {text}</span>
      {sub && <span className="small" style={{ opacity: 0.6 }}>{sub}</span>}
    </div>
  )
}

function Dashboard() {
  const [data, setData] = useState(null)
  const [loading, setLoading] = useState(true)

  const load = useCallback(async () => {
    setLoading(true)
    try { const res = await api.get('/dashboard'); setData(res.data) } catch { setData(null) } finally { setLoading(false) }
  }, [])

  useEffect(() => { queueMicrotask(() => load()) }, [load])

  const totals = data?.totals || {}
  const stats = [
    { title: 'Jumlah OPD', value: totals.opd ?? 0, icon: 'bi-building', className: 'stat-card-primary' },
    { title: 'Jumlah Walidata', value: totals.walidata ?? 0, icon: 'bi-people', className: 'stat-card-info' },
    { title: 'Sudah Sertifikasi', value: totals.sudah_sertifikasi ?? 0, icon: 'bi-patch-check', className: 'stat-card-success' },
    { title: 'Belum Sertifikasi', value: totals.belum_sertifikasi ?? 0, icon: 'bi-hourglass-split', className: 'stat-card-danger' },
    { title: 'Nilai Rata-rata', value: totals.nilai_rata_rata ?? 0, icon: 'bi-graph-up-arrow', className: 'stat-card-warning' },
  ]

  const progress = data?.training_progress
  const progressValue = Number(progress?.value || 0)
  const hasProgress = (progress?.total ?? 0) > 0

  const barOptions = (label) => ({
    maintainAspectRatio: false,
    indexAxis: 'y',
    plugins: { legend: { display: false }, tooltip: { callbacks: { label: (ctx) => `${ctx.parsed.x} ${label}` } } },
    scales: { x: { beginAtZero: true, grid: { color: '#eef2ff' } }, y: { grid: { display: false } } },
  })

  const doughnutOptions = {
    maintainAspectRatio: false,
    plugins: { legend: { position: 'bottom', labels: { padding: 12, usePointStyle: true, boxWidth: 8 } } },
    cutout: '60%',
  }

  return (
    <div>
      <div className="dashboard-hero mb-4">
        <div>
          <span className="dashboard-kicker"><i className="bi bi-stars me-1"></i>SIKAWAN ANALYTICS</span>
          <h3>Dashboard Kompetensi Walidata</h3>
          <p>Monitoring capaian kompetensi dan pembelajaran seluruh OPD.</p>
        </div>
        <button className="btn btn-light shadow-sm" onClick={load} disabled={loading}>
          {loading ? <><span className="spinner-border spinner-border-sm me-1" role="status"></span> Memuat...</> : <><i className="bi bi-arrow-clockwise me-1"></i>Perbarui Data</>}
        </button>
      </div>

      {loading && !data ? <div className="text-center py-5 text-muted">Memuat dashboard...</div> : <>
        <div className="row g-3 mb-4">
          {stats.map((s) => (
            <div className="col-sm-6 col-lg col-12" key={s.title}>
              <div className={`stat-card ${s.className} h-100`}>
                <div className="stat-card-body d-flex align-items-center">
                  <div>
                    <p className="stat-card-title">{s.title}</p>
                    <p className="stat-card-value">{s.value}</p>
                    <p className="stat-card-subtitle">Data terkini</p>
                  </div>
                  <div className="stat-card-icon ms-auto"><i className={`bi ${s.icon}`}></i></div>
                </div>
              </div>
            </div>
          ))}
        </div>

        <div className="row g-4 mb-4">
          <div className="col-md-6 col-lg-4">
            <div className="card h-100">
              <div className="card-body d-flex flex-column">
                <div className="chart-head mb-auto">
                  <div>
                    <h6>Distribusi Level</h6>
                    <p>Pemetaan level kompetensi Walidata</p>
                  </div>
                </div>
                <div style={{ position: 'relative', height: 250, width: '100%' }}>
                  {data?.level_distribution?.length ? (
                    <Doughnut data={makeChart(data.level_distribution, 'Walidata')} options={doughnutOptions} />
                  ) : <Empty text="level" sub="Belum ada level yang ditetapkan" />}
                </div>
              </div>
            </div>
          </div>

          <div className="col-md-6 col-lg-4">
            <div className="card h-100">
              <div className="card-body d-flex flex-column">
                <div className="chart-head mb-auto">
                  <div>
                    <h6>Status Asesmen</h6>
                    <p>Progres pengerjaan ujian Walidata</p>
                  </div>
                </div>
                <div style={{ position: 'relative', height: 250, width: '100%' }}>
                  {data?.asesmen_status?.length ? (
                    <Doughnut data={makeChart(data.asesmen_status, 'Peserta')} options={doughnutOptions} />
                  ) : <Empty text="asesmen" sub="Belum ada aktivitas ujian" />}
                </div>
              </div>
            </div>
          </div>

          <div className="col-md-12 col-lg-4">
            <div className="card h-100">
              <div className="card-body d-flex flex-column">
                <div className="chart-head mb-auto">
                  <div>
                    <h6>Progress Pelatihan</h6>
                    <p>Penyelesaian materi pembelajaran</p>
                  </div>
                </div>
                {hasProgress ? (
                  <div className="training-progress h-100">
                    <div className="progress-ring" style={{ '--progress': `${progressValue * 3.6}deg` }}>
                      <div className="progress-ring-inner">
                        <strong>{progressValue}%</strong>
                        <span>Progres</span>
                      </div>
                    </div>
                    <div className="training-details mt-3 text-center d-flex gap-3 justify-content-center">
                      <div>
                        <span>Selesai</span>
                        <strong>{progress?.completed ?? 0}</strong>
                      </div>
                      <div>
                        <span>Total</span>
                        <strong>{progress?.total ?? 0}</strong>
                      </div>
                    </div>
                  </div>
                ) : (
                  <Empty text="pelatihan" sub="Walidata belum mengakses materi" />
                )}
              </div>
            </div>
          </div>
        </div>

        <div className="row g-4 mb-4">
          <div className="col-lg-6">
            <div className="card h-100">
              <div className="card-body">
                <div className="chart-head">
                  <div>
                    <h6>Top 10 OPD</h6>
                    <p>Berdasarkan jumlah Walidata aktif</p>
                  </div>
                </div>
                <div style={{ height: 300, width: '100%' }}>
                  {data?.top_opd?.length ? (
                    <Bar data={makeChart(data.top_opd, 'Jumlah Walidata')} options={barOptions('Walidata')} />
                  ) : <Empty text="OPD" sub="Belum ada Walidata terdaftar" />}
                </div>
              </div>
            </div>
          </div>

          <div className="col-lg-6">
            <div className="card h-100">
              <div className="card-body">
                <div className="chart-head">
                  <div>
                    <h6>Top 10 Walidata</h6>
                    <p>Berdasarkan nilai kompetensi tertinggi</p>
                  </div>
                </div>
                <div style={{ height: 300, width: '100%' }}>
                  {data?.top_walidata?.length ? (
                    <Bar data={makeChart(data.top_walidata, 'Nilai Kompetensi')} options={{ ...barOptions('Nilai'), scales: { x: { min: 0, max: 100, grid: { color: '#eef2ff' } }, y: { grid: { display: false } } } }} />
                  ) : <Empty text="walidata" sub="Belum ada nilai kompetensi" />}
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="row g-4 mb-4">
          <div className="col-lg-5">
            <div className="card h-100">
              <div className="card-body d-flex flex-column">
                <div className="chart-head mb-auto">
                  <div>
                    <h6>Grafik Kompetensi</h6>
                    <p>Nilai rata-rata per domain kompetensi</p>
                  </div>
                  <span className="chart-chip">0–100</span>
                </div>
                <div style={{ position: 'relative', height: 320, width: '100%', marginTop: 10 }}>
                  {data?.kompetensi_scores?.length ? (
                    <Radar data={makeRadar(data.kompetensi_scores)} options={{
                      maintainAspectRatio: false,
                      scales: {
                        r: {
                          min: 0, max: 100,
                          ticks: { stepSize: 20, display: false },
                          grid: { color: '#e0e7ff' },
                          angleLines: { color: '#e0e7ff' },
                          pointLabels: { font: { size: 10, weight: '600' }, color: '#475569' },
                        },
                      },
                      plugins: { legend: { display: false } },
                    }} />
                  ) : <Empty text="grafik kompetensi" sub="Belum ada penilaian kompetensi" />}
                </div>
              </div>
            </div>
          </div>

          <div className="col-lg-7">
            <div className="card h-100">
              <div className="card-body">
                <div className="chart-head mb-4">
                  <div>
                    <h6>Peta Sebaran Kompetensi</h6>
                    <p>Ringkasan capaian nilai Walidata di tiap OPD</p>
                  </div>
                  <span className="chart-chip"><i className="bi bi-geo-alt me-1"></i>OPD</span>
                </div>
                {data?.kompetensi_map?.length ? (
                  <div className="kompetensi-map" style={{ maxHeight: 350, overflowY: 'auto', paddingRight: 5 }}>
                    {data.kompetensi_map.map((item) => {
                      const color = item.nilai >= 80 ? theme.emerald : item.nilai >= 60 ? theme.amber : theme.rose
                      return (
                        <div className="map-item mb-2" key={item.opd}>
                          <div className="map-score" style={{ background: color }}>{item.nilai}</div>
                          <div className="map-info">
                            <strong>{item.opd}</strong>
                            <span>{item.walidata} Walidata</span>
                          </div>
                          <div className="map-bar">
                            <div style={{ width: `${item.nilai}%`, background: color }}></div>
                          </div>
                        </div>
                      )
                    })}
                  </div>
                ) : <Empty text="peta sebaran" sub="Belum ada data OPD" />}
              </div>
            </div>
          </div>
        </div>
      </>}
    </div>
  )
}

export default Dashboard
