import streamlit as st
import pandas as pd
import plotly.express as px
from src.analytics import load_data, kpi_summary, channel_summary, monthly_trend, shortage_summary

st.set_page_config(page_title="Prescription Operations Analytics", layout="wide")
st.title("Prescription Operations Analytics — Synthetic Portfolio Demo")
st.caption("All data in this repository is synthetic. This demo generalizes a multi-branch operational analytics workflow.")

records, items, shortages, branches = load_data()
city = st.sidebar.multiselect("City", sorted(records.city.unique()))
branch = st.sidebar.multiselect("Branch", sorted(records.branch_id.unique()))
channel = st.sidebar.multiselect("Channel", sorted(records.channel.unique()))
filtered = records.copy()
if city: filtered = filtered[filtered.city.isin(city)]
if branch: filtered = filtered[filtered.branch_id.isin(branch)]
if channel: filtered = filtered[filtered.channel.isin(channel)]

k = kpi_summary(filtered)
cols = st.columns(6)
vals = [
    ("Records",k["total_records"]),("Done",k["done_records"]),("Not Yet",k["not_yet_records"]),
    ("Completion",f'{k["completion_rate"]:.1%}'),("Known Value",f'SAR {k["known_value_sar"]:,.0f}'),("Value N/A",k["value_na_records"])
]
for c,(label,value) in zip(cols,vals): c.metric(label,value)

st.subheader("Channel Performance")
cs = channel_summary(filtered)
st.dataframe(cs, use_container_width=True)
fig = px.bar(cs, x="channel", y="records", color="channel", text="records", title="Records by Operational Channel")
st.plotly_chart(fig, use_container_width=True)

st.subheader("Monthly Trend")
mt = monthly_trend(filtered)
st.plotly_chart(px.line(mt, x="month", y="records", color="channel", markers=True), use_container_width=True)

st.subheader("Open Item Requirements")
relevant = shortages[shortages.record_id.isin(filtered.record_id)]
st.dataframe(shortage_summary(relevant).head(25), use_container_width=True)

st.subheader("Operational Detail")
st.dataframe(filtered.sort_values("received_date", ascending=False).head(100), use_container_width=True)
